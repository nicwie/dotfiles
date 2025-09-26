pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    readonly property int cpuTemp: Math.round(cpuTempInternal / 1000)
    readonly property color tempColor: tempColorInternal

    property real cpuTempInternal: 0
    property color tempColorInternal: "red"

    Process {
        id: batteryProcess
        command: ["sh", "-c", "head -n 1 /sys/class/hwmon/hwmon5/temp1_input"]

        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                // There should be nothing output but the temp in MilliCelsius
                var temperature = parseFloat(this.text);
                var color;
                root.cpuTempInternal = temperature;
                temperature = temperature / 1000;
                if (temperature > 80) {
                    color = Colors.red;
                } else if (temperature > 60) {
                    color = Colors.peach;
                } else if (temperature > 50) {
                    color = Colors.green;
                } else {
                    color = Colors.sky;
                }
                root.tempColorInternal = color;
            }
        }
    }

    Timer {
        interval: 10000
        repeat: true
        running: true
        onTriggered: batteryProcess.running = true
    }
}
