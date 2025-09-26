pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property int number: updatesAmount + aurUpdatesAmount

    property int updatesAmount: 0
    property int aurUpdatesAmount: 0

    property string updates: ""

    property string aurUpdates: ""

    readonly property color updateColor: number == 0 ? Colors.flamingo : Colors.mauve

    Process {
        id: updateProcess
        command: ["sh", "-c", "checkupdates"]

        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.updatesAmount = this.text.split("\n").length - 1;
                root.updates = this.text;
            }
        }
    }

    Process {
        id: aurUpdateProcess

        command: ["sh", "-c", "yay -Qua"]

        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.aurUpdatesAmount = this.text.split("\n").length - 1;
                root.aurUpdates = this.text;
            }
        }
    }

    Timer {
        interval: 600000
        repeat: true
        running: true
        onTriggered: {
            updateProcess.running = true;
            aurUpdateProcess.running = true;
        }
    }
}
