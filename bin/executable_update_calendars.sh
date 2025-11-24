#!/bin/bash

# Exit immediately if error or unset var
set -eu

################################################################################
#  This fetches a specified calendar from a URL and imports it into khal.
#
# Arguments:
#     $1: The calendar's short name (e.g., "u", "g", "work")
#     $2: The url for the calendar
# Outputs:
#     Logs the progress of the sync operation
################################################################################
sync_calendar() {
    local cal_name="$1"
    local cal_url="$2"

    local local_dir="${XDG_DATA_HOME:-$HOME/.local/share}/calendars/$cal_name/"
    local temp_file="/tmp/$cal_name.ics"

    echo "Updating '$cal_name' calendar..."

    echo "Downloading..."
    if ! wget --quiet -O "$temp_file" "$cal_url"; then
        echo "ERROR: download of '$cal_url' failed."
        rm -f "$temp_file"
        return 1
    fi

    mkdir -p "$local_dir"

    echo "Clearing old -ics files from $local_dir".
    rm -f "$local_dir"/*.ics

    echo "Importing '$cal_name' to khal..."
    if ! khal import --batch "$temp_file" -a "$cal_name"; then
        echo "ERROR: khal import failed for '$cal_name'"
        rm -f "$temp_file"
        return 1
    fi

    rm -f "$temp_file"

    echo "Successfully updated '$cal_name' calendar"
}

main() {
    # Ensure the directory exists or source might fail
    mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/calendar-sync"

    # Use conditional sourcing so it doesn't crash if file is missing
    if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/calendar-sync/secrets" ]; then
        source "${XDG_CONFIG_HOME:-$HOME/.config}/calendar-sync/secrets"
    else
        echo "WARNING: Secrets file not found."
    fi

    echo "Starting calendar sync..."

    for var_name in $(compgen -v CAL_URL_ || true); do
        # remove "CAL_URL_" from name
        local cal_name_upper="${var_name#CAL_URL_}"

        # convert to lower case
        local cal_name="${cal_name_upper,,}"

        # Validate that the name is a simple string and contains no
        # dots, slashes, or other dangerous characters.
        if ! [[ "$cal_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
            echo "ERROR: Invalid or unsafe calendar name detected: '$cal_name'. Skipping."
            continue
        fi

        # get value of var
        local cal_url="${!var_name}"

        sync_calendar "$cal_name" "$cal_url"
    done

    echo "Updating 'tasks' calendar"
    if ! "$HOME/bin/tasks_to_ical.py"; then
        echo "ERROR: tasks_to_ical.py failed."
    else
        echo "'tasks' calendar updated."
    fi

    echo "Calendar update complete"
}

main
