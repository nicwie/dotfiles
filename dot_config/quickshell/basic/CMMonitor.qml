pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property bool isCapped: isCappedInternal

    property bool isCappedInternal: false

    property bool shouldCap: false

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
        command: ["sh", "-c", "ideapad-cm status"]

        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                if (this.text.includes("enabled")) {
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
        command: ["sh", "-c", "sudo ideapad-cm enable"]

        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                root.isCappedInternal = true;
            }
        }
    }

    Process {
        id: uncap
        command: ["sh", "-c", "sudo ideapad-cm disable"]

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
