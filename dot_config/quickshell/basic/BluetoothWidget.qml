import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    Layout.preferredWidth: background.implicitWidth
    Layout.preferredHeight: background.implicitHeight
    Layout.alignment: Qt.AlignLeft

    Rectangle {
        id: background
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        color: BluetoothMonitor.bluetoothColor
        implicitHeight: 30
        implicitWidth: 40

        Text {
            id: icon
            anchors.centerIn: parent
            font.pixelSize: 18
            // !TODO: Make this better (enabling, ...)
            text: BluetoothMonitor.adapter.enabled ? "" : "󰂲"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                BluetoothMonitor.switchEnable();
            }
        }
    }
}
