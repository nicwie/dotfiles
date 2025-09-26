import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: root
    Layout.preferredWidth: child.implicitWidth
    Layout.preferredHeight: child.implicitHeight
    Layout.alignment: Qt.AlignLeft
    property bool inhibited: IdleMonitor.inhibited

    Rectangle {
        id: child
        color: IdleMonitor.idleColor

        implicitHeight: 30
        implicitWidth: 60

        Text {
            id: icon
            anchors.centerIn: parent
            font.pixelSize: 20
            color: "#333333"

            text: root.inhibited ? "" : ""
            // tooltip: root.inhibited ? "Idling is disabled" : "Idling is enabled"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                IdleMonitor.inhibited = !IdleMonitor.inhibited;
            }
        }
    }
}
