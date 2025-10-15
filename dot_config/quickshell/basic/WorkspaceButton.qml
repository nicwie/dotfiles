import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Item {
    property var workspaceData
    property int workspaceIndex
    property int totalWorkspaces

    property color focusedTextColor: "#FFFFFF"
    property color unfocusedTextColor: "#FEDFE2"
    property color separatorBackgroundColor: Colors.mauve
    property color separatorForegroundColor: Colors.mantle

    readonly property bool isFocused: Hyprland.focusedWorkspace.id === workspaceData.id

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
                Hyprland.dispatch("workspace " + workspaceData.id);
            }

            Rectangle {
                id: workspaceRect

                anchors.fill: parent
                color: Colors.mauve
                visible: {
                    workspaceData.name < 11;
                }
                Text {
                    id: buttonText
                    text: workspaceData.name
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: 10
                    rightPadding: 10
                    font.pixelSize: 14

                    color: isFocused ? focusedTextColor : unfocusedTextColor
                    font.bold: Hyprland.focusedWorkspace.id === workspaceData.id
                }
            }
        }
    }
}
