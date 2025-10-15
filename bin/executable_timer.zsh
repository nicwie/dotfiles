#!/bin/zsh

# Timer script using 'at' and 'notify-send'

DEFAULT_MESSAGE="Time's up!"
NOTIFICATION_TITLE="Timer Finished"

# check if 'at' running
if ! pgrep -x "atd" >/dev/null; then
    echo "Error: The 'at' daemon (atd) is not running." >&2
    echo "This service is required to schedule the timer." >&2
    echo "On most systemd-based systems, you can start and enable it with:" >&2
    echo "  sudo systemctl enable --now atd" >&2
    exit 1
fi

# check for commands
if ! command -v at &>/dev/null || ! command -v notify-send &>/dev/null; then
    echo "Error: This script requires 'at' and 'notify-send'." >&2
    echo "Please install them to continue." >&2
    exit 1
fi

# Show usage if no arguments are provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $(basename $0) <time_spec> [optional_message]"
    echo "\n<time_spec> is any format 'at' understands, e.g.:"
    echo "  '5 minutes'"
    echo "  '1 hour 30 minutes'"
    echo "  '10min'"
    echo "\nExample:"
    echo "  $(basename $0) '15 minutes' 'Check the pizza!'"
    exit 0
fi

TIME_SPEC="$1"
# any more arguments are used for the timer message
if [ "$#" -gt 1 ]; then
    shift
    MESSAGE="$*"
else
    MESSAGE="$DEFAULT_MESSAGE"
fi

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    echo "Warning: DBUS_SESSION_BUS_ADDRESS is not set." >&2
    echo "The notification may not appear. Trying to continue anyway." >&2
fi

SCHEDULED_COMMAND="export DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS; notify-send -a 'Timer' --urgency=critical '$NOTIFICATION_TITLE' '$MESSAGE'"

# Schedule the command
at "now + $TIME_SPEC" <<<"$SCHEDULED_COMMAND"

if [ $? -eq 0 ]; then
    # at returns 0 on success
    echo "Timer set for $TIME_SPEC from now."
    echo " Message: \"$MESSAGE\""
else
    # at returns non-zero on failure
    echo "Error: Could not set timer." >&2
    echo " Please check your time specification. Examples: '10 min', '1 hour', '2 days'." >&2
fi
