// Bar.qml
import Quickshell
import QtQuick.Layouts
import QtQuick
import Quickshell.Hyprland

Scope {

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            property var modelData
            screen: modelData

            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30
            implicitWidth: content.width

            RowLayout {
                id: content
                anchors.fill: parent
                spacing: 0

                // Widgets on the left
                IdleWidget {}

                Triangle {
                    backgroundColor: CMMonitor.cMColor
                    foregroundColor: IdleMonitor.idleColor
                }

                CMWidget {}

                Triangle {
                    backgroundColor: TemperatureMonitor.tempColor
                    foregroundColor: CMMonitor.cMColor
                }

                TemperatureWidget {}

                Triangle {
                    backgroundColor: BatteryMonitor.batteryColor
                    foregroundColor: TemperatureMonitor.tempColor
                }

                BatteryWidget {}

                Triangle {
                    backgroundColor: CPUMonitor.cpuColor
                    foregroundColor: BatteryMonitor.batteryColor
                }

                CPUWidget {}

                Triangle {
                    backgroundColor: MemoryMonitor.memColor
                    foregroundColor: CPUMonitor.cpuColor
                }

                MemoryWidget {}

                Triangle {
                    backgroundColor: UpdateMonitor.updateColor
                    foregroundColor: MemoryMonitor.memColor
                }

                UpdateWidget {}

                Triangle {
                    backgroundColor: Colors.maroon
                    foregroundColor: UpdateMonitor.updateColor
                }

                TrayWidget {}

                Triangle {
                    backgroundColor: "transparent"
                    foregroundColor: Colors.maroon
                }

                // Spacer
                Spacer {}

                Triangle {
                    backgroundColor: Colors.mauve
                    foregroundColor: "transparent"
                }

                RowLayout {
                    id: workspaceContainer
                    spacing: 0

                    Repeater {
                        id: workspaceRepeater
                        model: Hyprland.workspaces

                        delegate: WorkspaceButton {
                            // width: 10 * workspaceRepeater.count
                            workspaceData: modelData
                            workspaceIndex: index
                            totalWorkspaces: workspaceRepeater.count
                        }
                    }
                }

                Triangle {
                    backgroundColor: "transparent"
                    foregroundColor: Colors.mauve
                }

                Spacer {}

                Triangle {
                    backgroundColor: BluetoothMonitor.bluetoothColor
                    foregroundColor: "transparent"
                }

                BluetoothWidget {}

                Triangle {
                    backgroundColor: AudioMonitor.audioColor
                    foregroundColor: BluetoothMonitor.bluetoothColor
                }

                AudioWidget {}

                Triangle {
                    backgroundColor: WifiMonitor.wifiColor
                    foregroundColor: AudioMonitor.audioColor
                }

                WifiWidget {}

                Triangle {
                    backgroundColor: PowerprofileMonitor.profileColor
                    foregroundColor: WifiMonitor.wifiColor
                }

                PowerprofileWidget {}

                Triangle {
                    foregroundColor: PowerprofileMonitor.profileColor
                    backgroundColor: BrightnessMonitor.brightnessColor
                }

                BrightnessWidget {}

                Triangle {
                    backgroundColor: Time.timeColor
                    foregroundColor: BrightnessMonitor.brightnessColor
                }

                ClockWidget {}
            }
        }
    }
}
