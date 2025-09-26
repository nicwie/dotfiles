pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property int brightnessPercent: internalBrightnessPercent

    property color brightnessColor: Colors.pink

    readonly property int internalBrightnessPercent: {
        Math.round((brightness / maxBrightness) * 100);
    }

    property real brightness: 0
    property real maxBrightness: 1

    Process {
        id: getMaxProcess
        command: ["sh", "-c", "brightnessctl m"]

        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.maxBrightness = parseFloat(this.text);
            }
        }
    }
    Process {
        id: brightnessProcess
        command: ["sh", "-c", "brightnessctl g"]

        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.brightness = parseFloat(this.text);
            }
        }
    }

    function setBrightness(level: int): void {
        brightnessPercent = level;
        Quickshell.execDetached(["brightnessctl", "s", level + "%"]);
    }

    Timer {
        interval: 2000
        repeat: true
        running: true
        onTriggered: brightnessProcess.running = true
    }
}
