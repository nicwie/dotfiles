import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Item {
    id: root
    property var workspaceData
    property int workspaceIndex
    property int totalWorkspaces

    property color focusedTextColor: "#FFFFFF"
    property color unfocusedTextColor: "#FEDFE2"

    readonly property bool isFocused: (Hyprland.focusedWorkspace && workspaceData) ? (Hyprland.focusedWorkspace.id === workspaceData.id) : false

    implicitWidth: buttonLayout.implicitWidth
    implicitHeight: 30

    RowLayout {
        id: buttonLayout
        anchors.fill: parent
        spacing: 0

        MouseArea {
            width: workspaceRect.visible ? buttonText.implicitWidth : 0
            height: 30
            onClicked: {
                if (root.workspaceData)
                    Hyprland.dispatch("workspace " + root.workspaceData.id);
            }

            Rectangle {
                id: workspaceRect

                anchors.fill: parent
                color: Colors.mauve
                visible: {
                    root.workspaceData ? root.workspaceData.name < 11 : false;
                }
                Text {
                    id: buttonText
                    text: workspaceData ? root.workspaceData.name.toString() : ""
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: 10
                    rightPadding: 10
                    font.pixelSize: 14

                    color: isFocused ? focusedTextColor : unfocusedTextColor
                    font.bold: root.isFocused
                }
            }
        }
    }
}
