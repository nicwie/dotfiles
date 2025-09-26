import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    Layout.preferredWidth: content.implicitWidth + 25
    Layout.preferredHeight: child.implicitHeight
    Layout.alignment: Qt.AlignLeft
    Rectangle {
        id: child
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: BatteryMonitor.batteryColor
        implicitHeight: 30
        width: root.width + 1
        Text {
            id: content
            anchors.centerIn: parent
            property real percentage: BatteryMonitor.percentage
            property real changeRate: BatteryMonitor.changeRate
            text: getText()
            function getText() {
                if (changeRate == 0) {
                    return "   " + percentage + "%";
                } else if (percentage > 75) {
                    return "   " + percentage + "% " + changeRate + "W";
                } else if (percentage > 50) {
                    return "   " + percentage + "% " + changeRate + "W";
                } else if (percentage > 20) {
                    return "   " + percentage + "% " + changeRate + "W";
                } else {
                    return "   " + percentage + "% " + changeRate + "W";
                }
            }
        }
    }
}
