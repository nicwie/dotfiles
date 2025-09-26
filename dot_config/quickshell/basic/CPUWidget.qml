import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    Layout.preferredWidth: child.implicitWidth
    Layout.preferredHeight: child.implicitHeight
    Layout.alignment: Qt.AlignLeft
    Rectangle {
        id: child
        anchors.fill: parent
        color: CPUMonitor.cpuColor
        implicitHeight: 30
        implicitWidth: 60
        Text {
            id: content
            anchors.centerIn: parent
            property string usagePercent: CPUMonitor.usagePercent
            text: "  " + usagePercent + "%"
        }
    }
}
