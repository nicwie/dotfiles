import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    Layout.preferredWidth: child.implicitWidth
    Layout.preferredHeight: child.implicitHeight
    Layout.alignment: Qt.AlignLeft
    Rectangle {
        id: child
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: PowerprofileMonitor.profileColor
        implicitHeight: 30
        implicitWidth: 40
        Text {
            id: icon
            property int profile: PowerprofileMonitor.profile
            property string profileIcon: getIcon()
            anchors.centerIn: parent
            font.pixelSize: 18
            text: profileIcon
            function getIcon() {
                if (profile == 1) {
                    return "";
                } else if (profile == 2) {
                    return "";
                } else {
                    return "";
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                PowerprofileMonitor.switchProfile = true;
            }
        }
    }
}
