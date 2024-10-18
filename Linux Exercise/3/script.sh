#!/bin/bash

# Linux Training Assignment-3 
# Make this script executable by giving appropriate file permissions.
create_process() {
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")  # Generate a unique timestamp
  PROCESS_NAME="Kill_Me_Please_$TIMESTAMP"
  
  exec -a "$PROCESS_NAME" sleep 1000 &
  
  PID=$!
  
  echo "Started $PROCESS_NAME with PID $PID"
}

while true
do
  create_process
  
  sleep 30
done
