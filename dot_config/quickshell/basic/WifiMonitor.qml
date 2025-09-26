pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    readonly property int wifiPercent: {
        Math.round(2 * (strength + 100));
    }

    readonly property color wifiColor: color

    readonly property string wifiName: name

    readonly property bool state: connected

    property string name: ""
    property real strength: -100
    property bool connected: false
    property color color: connected ? Colors.blue : Colors.red

    Process {
        id: wifiProcess
        command: ["iwctl", "station", "wlan0", "show"]

        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                var lines = this.text;
                lines = lines.trim().split('\n');

                var parsedState = false;
                var parsedName = "Disconnected";
                var parsedRssi = -100;

                for (var i = 0; i < lines.length; i++) {
                    var line = lines[i].trim();
                    if (line.startsWith("State")) {
                        if (line.includes("connected") && !line.includes("disconnected")) {
                            parsedState = true;
                        }
                    } else if (line.startsWith("Connected network")) {
                        var parts = line.split(/\s+/);
                        parsedName = parts[parts.length - 1];
                    } else if (line.startsWith("AverageRSSI")) {
                        var parts = line.split(/\s+/);
                        if (parts.length > 1) {
                            parsedRssi = parseInt(parts[1], 10);
                        }
                    }
                }
                root.connected = parsedState;
                root.name = parsedState ? parsedName : "Disconnected";
                root.strength = parsedState ? parsedRssi : -100;
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if (this.text) {
                    console.log("Wi-Fi Status Error:", this.text.trim());
                    root.connected = false;
                    root.name = "Device error";
                    root.strength = -100;
                }
            }
        }
    }

    Timer {
        interval: 15000
        repeat: true
        running: true
        onTriggered: wifiProcess.running = true
    }
}
