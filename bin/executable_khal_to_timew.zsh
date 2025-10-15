#!/bin/zsh

# Ensure zsh features like process substitution are available
setopt local_options KSH_ARRAYS BASH_REMATCH

KHAL_DATETIME_FORMAT="{start} {end} {title}"

# Function to parse and get epoch time.
get_epoch_time() {
    local datetime_str=$1
    date -d "$datetime_str" +%s 2>/dev/null
}

# --- Main Logic ---

echo "Searching for a currently running khal event..."

# Get current time as epoch seconds
now_epoch=$(date +%s 2>/dev/null)
if [[ -z "$now_epoch" ]]; then
    echo "ERROR: Could not get current epoch time. Is GNU date or gdate available?"
    exit 1
fi

found_event_line=""

# 1. Look for a currently running event by checking all events today
while IFS= read -r line; do
    # Skip empty lines
    [[ -z "$line" ]] && continue

    # Extract start and end date/time strings
    start_str=$(echo "$line" | awk '{print $1" "$2}')
    end_str=$(echo "$line" | awk '{print $3" "$4}')

    # Attempt to parse dates and get epoch times
    start_epoch=$(get_epoch_time "$start_str")
    end_epoch=$(get_epoch_time "$end_str")

    # Skip if parsing failed
    if [[ -z "$start_epoch" || -z "$end_epoch" ]]; then
        # echo "Skipping line with unparsable date: $line"
        continue
    fi

    # Check if current time falls within the event (start <= now < end)
    if ((start_epoch <= now_epoch && end_epoch > now_epoch)); then
        found_event_line=$line
        break # Stop after finding the first running event
    fi
done < <(khal list today --format "$KHAL_DATETIME_FORMAT") # List all today's events

# 2. If a running event was found, start timewarrior
if [[ -n "$found_event_line" ]]; then
    echo "Found currently running event: $found_event_line"

    # Extract the title
    title=$(echo "$found_event_line" | awk '{$1=$2=$3=$4=""; print $0}' | sed 's/^ *//;s/ *$//') # Remove leading/trailing spaces

    # Check if title was extracted
    if [[ -z "$title" ]]; then
        echo "Error: Could not extract title from the event."
        exit 1
    fi

    # Start timewarrior tracking now with the event title
    echo "Starting Timewarrior tracking now with title: '$title'"
    timew start "$title"

    # Check if timew start was successful
    if [[ $? -eq 0 ]]; then
        echo "Timewarrior tracking started."
    else
        echo "Failed to start Timewarrior. Is a task already running?"
        exit 1
    fi
else
    # 3. If no running event was found, do nothing
    echo "No currently running event found in khal. No action taken."
    exit 0
fi

exit 0
