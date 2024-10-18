#!/bin/bash

# Define the log file
LOG_FILE="killed_processes.log"

# Ensure the log file exists
touch "$LOG_FILE"

# Function to monitor and kill processes
monitor_processes() {
  while true; do
    # Get the list of process IDs starting with "Kill_Me"
    pids=$(pgrep -f "^Kill_Me")

    for pid in $pids; do
      # Get the command name associated with the PID
      name=$(ps -p "$pid" -o comm=)

      # Terminate the process
      kill "$pid"

      # Check if the kill command was successful
      if [ $? -eq 0 ]; then
        # Log the terminated process details
        TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
        echo "$TIMESTAMP: Terminated process '$name' with PID $pid" >> "$LOG_FILE"
      fi
    done

    # Sleep for a short while before checking again
    sleep 5
  done
}

# Start the monitoring function
monitor_processes
