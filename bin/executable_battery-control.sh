#!/bin/bash
# Hardcoded path for security
BAT_PATH="/sys/class/power_supply/BAT0/charge_types"

case "$1" in
"on")
    echo 'Long_Life' >"$BAT_PATH"
    ;;
"off")
    echo 'Standard' >"$BAT_PATH"
    ;;
"status")
    cat "$BAT_PATH"
    ;;
*)
    echo "Usage: $0 {on|off|status}"
    exit 1
    ;;
esac
