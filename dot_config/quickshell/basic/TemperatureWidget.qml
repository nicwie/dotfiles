import QtQuick
import Quickshell
import QtQuick.Layouts

Item {
    Layout.preferredWidth: child.implicitWidth
    Layout.preferredHeight: child.implicitHeight
    Layout.alignment: Qt.AlignLeft
    Rectangle {
        id: child
        anchors.fill: parent
        color: TemperatureMonitor.tempColor
        implicitHeight: 30
        implicitWidth: 60
        Text {
            property int cpuTemp: TemperatureMonitor.cpuTemp
            anchors.centerIn: parent
            text: getText() + "°C"
            function getText() {
                if (cpuTemp > 80) {
                    return " " + cpuTemp;
                } else if (cpuTemp > 50) {
                    return " " + cpuTemp;
                } else {
                    return " " + cpuTemp;
                }
            }
        }
        // MouseArea {
        //     visible: false
        //     hoverEnabled: true
        //     onEntered: batteryTooltip.visible = true
        //     enExited: batteryTooltip.visible = false
        //     ToolTip {
        //         id: batteryTooltip
        //         Text {
        //             text: "aaa"
        //         }
        //     }
        // }
    }
}
