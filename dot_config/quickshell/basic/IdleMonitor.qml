pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property bool inhibited: false
    readonly property color idleColor: inhibited ? Colors.sapphire : Colors.green

    Process {
        id: idleProcess
        running: root.inhibited

        command: ["systemd-inhibit", "--what=idle", "--who=Quickshell", "--why=Manual toggle in status bar", "sleep", "infinity"]
    }
}
