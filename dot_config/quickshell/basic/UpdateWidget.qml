import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    Layout.preferredWidth: (content.implicitWidth > 0) ? content.implicitWidth + 20 : 1
    Layout.preferredHeight: child.implicitHeight
    Layout.alignment: Qt.AlignLeft

    property int updatesAmount: UpdateMonitor.updatesAmount
    property int aurUpdatesAmount: UpdateMonitor.aurUpdatesAmount
    property string updates: UpdateMonitor.updates
    property string aurUpdates: UpdateMonitor.aurUpdates

    Rectangle {
        id: child
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: UpdateMonitor.updateColor
        implicitHeight: 30
        width: parent.width + 1
        Text {
            id: content
            anchors.centerIn: parent
            property string number: UpdateMonitor.number
            text: getNumber()
            function getNumber() {
                if (number == 0) {
                    return "";
                } else {
                    return "  " + number;
                }
            }
        }
        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                updateTooltip.visible = true;
            }

            onExited: {
                updateTooltip.visible = false;
            }

            PanelWindow {
                id: updateTooltip
                color: UpdateMonitor.updateColor
                visible: false

                implicitWidth: updateText.width + 15
                implicitHeight: getHeight()
                anchors.top: mouse.bottom
                anchors.left: mouse.left
                // anchors.topMargin: 5
                // visible: mouse.hoveredOn // need to put a mousearea here so we know when the mouse is here
                Text {
                    id: updateText
                    // qsTr("󰣇 " + updatesAmount + "  AUR: " + aurUpdatesAmount + "\n" + updates + aurUpdates);
                    // qsTr("aaaaaaaaaaaaaa");

                    text: "󰣇 " + updatesAmount + "  AUR: " + aurUpdatesAmount + "\n" + updates + aurUpdates
                }

                function getHeight() {
                    return updateText.text.split("\n").length * (updateText.font.pixelSize + 5);
                }
            }
        }
    }
}
