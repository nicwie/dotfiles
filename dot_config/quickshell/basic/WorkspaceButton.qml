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
            width: buttonText.implicitWidth
            height: 30
            onClicked: {
                Hyprland.dispatch("workspace " + workspaceData.id);
            }

            Rectangle {
                anchors.fill: parent
                color: Colors.mauve
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
