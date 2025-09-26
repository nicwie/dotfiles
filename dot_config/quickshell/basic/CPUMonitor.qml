pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    readonly property int usagePercent: {
        Math.round(usage * 100);
    }

    property real usage: 0
    property real lastTotal: 0
    property real lastIdle: 0

    property color cpuColor: (usagePercent > 70) ? Colors.peach : Colors.teal

    Process {
        id: cpuProcess
        command: ["sh", "-c", "head -n 1 /proc/stat"]

        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var fields = this.text.substring(5).split(" ");
                var idle = parseFloat(fields);
                var total = 0;
                for (var i = 0; i < fields.length; i++) {
                    total += parseFloat(fields[i]);
                }

                var totalDiff = total - root.lastTotal;
                var idleDiff = idle - root.lastIdle;

                if (totalDiff > 0) {
                    root.usage = (idleDiff / totalDiff);
                }

                root.lastTotal = total;
                root.lastIdle = idle;
            }
        }
    }

    Timer {
        interval: 5000
        repeat: true
        running: true
        onTriggered: cpuProcess.running = true
    }
}
