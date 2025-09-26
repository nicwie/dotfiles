import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    Layout.preferredWidth: child.implicitWidth
    Layout.preferredHeight: child.implicitHeight
    Layout.alignment: Qt.AlignLeft
    Rectangle {
        id: child
        color: Time.timeColor
        anchors.fill: parent
        implicitWidth: 120
        implicitHeight: 30
        Text {
            id: content
            color: Colors.mantle
            anchors.centerIn: parent
            text: Time.time
        }
    }
}
