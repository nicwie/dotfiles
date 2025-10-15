#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Define calendar URLs and local directories
LOCAL_DIR_U="$HOME/.local/share/calendars/u/"
LOCAL_DIR_G="$HOME/.local/share/calendars/g/"
TEMP_FILE_U="/tmp/u.ics"
TEMP_FILE_G="/tmp/g.ics"
# Source the private URLs from a separate config file
# Fails if the file doesn't exist
source "$HOME/.config/calendar-sync/secrets"

# --- Update 'u' calendar ---
echo "Updating 'u' calendar..."
# Download the latest .ics file
wget -O "$TEMP_FILE_U" "$URL_U"

# Clear the local calendar directory
rm -f "$LOCAL_DIR_U"/*.ics

# Import the downloaded file into khal
khal import --batch "$TEMP_FILE_U" -a u

# Clean up temporary file
rm -f "$TEMP_FILE_U"

echo "'u' calendar updated."

# --- Update 'g' calendar ---
echo "Updating 'g' calendar..."
# Download the latest .ics file
wget -O "$TEMP_FILE_G" "$URL_G"

# Clear the local calendar directory
rm -f "$LOCAL_DIR_G"/*.ics

# Import the downloaded file into khal
khal import --batch "$TEMP_FILE_G" -a g

# Clean up temporary file
rm -f "$TEMP_FILE_G"

echo "'g' calendar updated."

echo "updating 'tasks' calendar..."

~/bin/tasks_to_ical.py

echo "'tasks' calendar updated."

echo "Calendar update complete."
