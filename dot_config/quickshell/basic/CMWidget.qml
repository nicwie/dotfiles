import QtQuick
import QtQuick.Layouts
import Quickshell

Item {
    id: root
    Layout.preferredWidth: child.implicitWidth
    Layout.preferredHeight: child.implicitHeight
    Layout.alignment: Qt.AlignLeft

    Rectangle {
        id: child
        color: CMMonitor.cMColor

        implicitHeight: 30
        implicitWidth: 40

        Text {
            id: icon
            anchors.centerIn: parent
            font.pixelSize: 20
            color: "#333333"

            text: CMMonitor.isCapped ? "󰌢" : "󰛧"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                if (CMMonitor.isCapped) {
                    CMMonitor.shouldCap = false;
                } else {
                    CMMonitor.shouldCap = true;
                }
            }
        }
    }
}
