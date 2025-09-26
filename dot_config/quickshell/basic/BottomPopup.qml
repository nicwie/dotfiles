import Quickshell
import QtQuick.Layouts
import QtQuick

Scope {
    Variants {

        model: Quickshell.screens
        PanelWindow {
            id: bottomPopup
            property var modelData
            screen: modelData

            color: "transparent"
            // color: "blue"

            exclusiveZone: 0

            implicitHeight: 40
            implicitWidth: 1000
            visible: true

            anchors {
                bottom: true
            }

            Rectangle {
                id: bottomBackground
                anchors {
                    bottom: parent.bottom
                }
                implicitWidth: parent.width
                implicitHeight: parent.height
                color: "transparent"
                // color: Colors.green
                MouseArea {
                    anchors.fill: parent
                    implicitHeight: parent.height
                    implicitWidth: parent.width
                    hoverEnabled: true
                    onEntered: {
                        bottomMouseArea.visible = true;
                    }
                }
            }
            PopupWindow {
                id: bottomMouseArea
                anchor.item: bottomBackground
                color: "transparent"
                visible: false
                implicitWidth: content.width
                implicitHeight: content.height
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    enabled: bottomMouseArea.visible
                    onExited: {
                        bottomMouseArea.visible = false;
                    }
                }
                Rectangle {
                    id: backgroundRect
                    anchors.fill: parent
                    implicitHeight: 300
                    implicitWidth: 1000
                    color: Colors.mauve
                    radius: 20
                    ColumnLayout {
                        id: content
                        anchors.fill: parent
                        spacing: 10
                        MusicWidget {}
                    }
                }
            }
        }
    }
}
