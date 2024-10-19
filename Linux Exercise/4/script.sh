#!/bin/bash

# Load the configuration file"
source "/home/shtlp_0147/Assignment_3-Linux_and_Sql-/Linux Exercise/4/config.env"

# Largest file tracking
LARGEST_FILE=""
LARGEST_FILE_SIZE=0

# 1. Initialize the last scan file with a list of current files and their modification times
initialize_last_scan() {
    echo "Initializing the scan for the directory: $MONITOR_DIR"
    find "$MONITOR_DIR" -type f -exec stat --format='%Y %n' {} \; > "$TEMP_FILE"
}

# 2. Function to log file changes
log_file_change() {
    local EVENT=$1
    local FILE_PATH=$2
    local FILE_NAME=$(basename "$FILE_PATH")
    local FILE_SIZE=$(stat -c%s "$FILE_PATH")
    local TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

    # Log event details
    echo "$TIMESTAMP: $EVENT detected on '$FILE_NAME' (Size: $FILE_SIZE bytes)" >> "$LOG_FILE"
}

# 3. Function to scan and compare file sizes to find the largest file
find_largest_file() {
    echo "Scanning for the largest file in $MONITOR_DIR"
    LARGEST_FILE=$(find "$MONITOR_DIR" -type f -exec stat --format='%s %n' {} \; | sort -n | tail -1)
    LARGEST_FILE_SIZE=$(echo "$LARGEST_FILE" | cut -d' ' -f1)
    LARGEST_FILE_PATH=$(echo "$LARGEST_FILE" | cut -d' ' -f2-)

    echo "Largest file: $LARGEST_FILE_PATH (Size: $LARGEST_FILE_SIZE bytes)"
    echo "$(date +"%Y-%m-%d %H:%M:%S"): Largest file: $LARGEST_FILE_PATH (Size: $LARGEST_FILE_SIZE bytes)" >> "$LOG_FILE"
}

# 4. Function to upload new or modified file content to MySQL, ensuring no duplicates
upload_to_sql() {
    local FILE_PATH=$1
    local FILE_NAME=$(basename "$FILE_PATH")
    local FILE_SIZE=$(stat -c%s "$FILE_PATH")

    # Read file content
    FILE_CONTENT=$(cat "$FILE_PATH")

    # Check for duplicate based on file name in the database
    local DUPLICATE=$(mysql -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -se "SELECT COUNT(*) FROM files WHERE name='$FILE_NAME';")

    if [ "$DUPLICATE" -eq 0 ]; then
        # If no duplicate, insert the file content into the database
        mysql -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "INSERT INTO files (name, size, content, modified_at) VALUES ('$FILE_NAME', $FILE_SIZE, '$FILE_CONTENT', NOW());"
        echo "$(date +"%Y-%m-%d %H:%M:%S"): Uploaded file '$FILE_NAME' to MySQL" >> "$LOG_FILE"
    else
        echo "$(date +"%Y-%m-%d %H:%M:%S"): Duplicate file '$FILE_NAME' not uploaded" >> "$LOG_FILE"
    fi
}

# 5. Function to monitor for new or modified files
monitor_directory() {
    echo "Starting directory monitoring for $MONITOR_DIR"
    while true; do
        # Temporary file for the new scan
        NEW_SCAN="/home/shtlp_0147/Assignment_3-Linux_and_Sql-/Linux Exercise/4/new_scan.txt"
	# new_scan.txt

        # Get the list of current files and their modification times
        find "$MONITOR_DIR" -type f -exec stat --format='%Y %n' {} \; > "$NEW_SCAN"

        # Compare the previous scan with the current scan
        # Check for new or modified files
        while read -r line; do
            MOD_TIME=$(echo "$line" | awk '{print $1}')
            FILE_PATH=$(echo "$line" | cut -d' ' -f2-)

            # Check if the file is new or has been modified
            if ! grep -q "$FILE_PATH" "$TEMP_FILE"; then
                # New file detected
                log_file_change "CREATE" "$FILE_PATH"

                # Find and log the largest file after the new addition
                find_largest_file

                # Upload the file content to SQL
                upload_to_sql "$FILE_PATH"

            else
                # Check if the modification time has changed
                LAST_MOD_TIME=$(grep "$FILE_PATH" "$TEMP_FILE" | awk '{print $1}')
                if [ "$MOD_TIME" -ne "$LAST_MOD_TIME" ]; then
                    log_file_change "MODIFY" "$FILE_PATH"

                    # Re-check the largest file in case the modified file is now larger
                    find_largest_file

                    # Upload the updated file content to SQL
                    upload_to_sql "$FILE_PATH"
                fi
            fi
        done < "$NEW_SCAN"

        # Update the last scan file
        mv "$NEW_SCAN" "$TEMP_FILE"

        # Sleep for a while before the next scan
        sleep 10
    done
}

# 6. Start the process by initializing the scan and monitoring directory
initialize_last_scan
monitor_directory
