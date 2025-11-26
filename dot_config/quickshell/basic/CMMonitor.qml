pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property bool isCapped: isCappedInternal
    property bool isCappedInternal: false
    property bool shouldCap: false

    // Path to the battery control file (this is system dependent)
    readonly property string batteryPath: "/sys/class/power_supply/BAT0/charge_types"

    onShouldCapChanged: {
        if (shouldCap != isCapped) {
            if (shouldCap) {
                cap.running = true;
            } else {
                uncap.running = true;
            }
        }
    }

    readonly property color cMColor: isCapped ? Colors.pink : Colors.teal

    Process {
        id: checkCapped
        command: ["cat", root.batteryPath]

        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                // The file looks like: "Standard [Long_Life]" when capped
                // or "[Standard] Long_Life" when uncapped.
                // We check if "Long_Life" is inside brackets.
                if (this.text.includes("[Long_Life]")) {
                    root.isCappedInternal = true;
                    root.shouldCap = true;
                } else {
                    root.isCappedInternal = false;
                    root.shouldCap = false;
                }
            }
        }
    }

    Process {
        id: cap
        // command: ["sh", "-c", "sudo ideapad-cm enable"]
        command: ["sudo", "/home/nicwie1/bin/battery-control.sh", "on"]

        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                root.isCappedInternal = true;
            }
        }
    }

    Process {
        id: uncap
        // command: ["sh", "-c", "sudo ideapad-cm disable"]
        command: ["sudo", "/home/nicwie1/bin/battery-control.sh", "off"]

        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                root.isCappedInternal = false;
            }
        }
    }

    Timer {
        interval: 10000
        repeat: true
        running: true
        onTriggered: checkCapped.running = true
    }
}
