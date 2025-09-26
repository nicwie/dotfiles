import QtQuick
import Quickshell
import Quickshell.Hyprland

Scope {
    id: bar

    Variants {
        model: {
            const screens = Quickshell.screens;
            return screens;
        }

        PanelWindow {
            id: barRoot
            required property ShellScreen modelData
            screen: modelData

            property var brightnessMonitor: Brightness.getMonitorForScreen(modelData)

            color: "tranparent"

            anchors {
                top: true
                left: true
                right: true
            }

            Item {
                id: barContent
                anchors: {
                    right: parent.right;
                    left: parent.left;
                    right: parent.right;
                    bottom: parent.bottom;
                }

                implicitHeight: 30
                height: 30
            }
        }
    }
}
