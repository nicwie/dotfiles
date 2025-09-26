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
        color: MemoryMonitor.memColor
        implicitHeight: 30
        implicitWidth: 60

        Text {
            property string usagePercent: MemoryMonitor.usagePercent
            anchors.centerIn: parent
            text: "  " + usagePercent + "%"
        }
    }
}
