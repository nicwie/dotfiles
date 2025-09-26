pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property int usagePercent: (total > 0) ? Math.round(used / total * 100) : 0

    property real total: 0
    property real used: 0

    property color memColor: (usagePercent > 70) ? Colors.yellow : Colors.sky

    Process {
        id: memProcess
        running: true
        command: ["sh", "-c", "free -m | grep Mem:"]

        stdout: StdioCollector {
            onStreamFinished: {
                var fields = this.text.trim().split(/\s+/);
                for (var i = 0; i < fields.length; i++) {}
                if (fields.length > 2) {
                    root.total = parseInt(fields[1]);
                    root.used = parseInt(fields[2]);
                }
            }
        }
    }

    Timer {
        interval: 5000
        repeat: true
        running: true
        onTriggered: memProcess.running = true
    }
}
