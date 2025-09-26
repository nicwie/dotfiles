pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property color timeColor: Colors.lavender

    readonly property string time: {
        Qt.formatDateTime(clock.date, "ddd MMM d hh:mm AP");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
