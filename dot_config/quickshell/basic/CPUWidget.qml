import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    Layout.preferredWidth: child.implicitWidth
    Layout.preferredHeight: child.implicitHeight
    Layout.alignment: Qt.AlignLeft
    Rectangle {
        id: child
        anchors.fill: parent
        color: CPUMonitor.cpuColor
        implicitHeight: 30
        implicitWidth: 60
        Text {
            id: content
            anchors.centerIn: parent
            property string usagePercent: CPUMonitor.usagePercent
            text: "  " + usagePercent + "%"
        }
        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                detailTooltip.visible = true;
                CPUMonitor.detailedViewActive = true;
            }
            onExited: {
                detailTooltip.visible = false;
                CPUMonitor.detailedViewActive = false;
            }

            PanelWindow {
                id: detailTooltip
                color: CPUMonitor.cpuColor
                visible: false

                implicitWidth: detailText.width + 15
                implicitHeight: getHeight()

                anchors.top: mouse.bottom
                anchors.left: mouse.left

                Text {
                    id: detailText
                    text: CPUMonitor.cpuDetail
                }

                function getHeight() {
                    return detailText.text.split("\n").length * (detailText.font.pixelSize + 5);
                }
            }
        }
    }
}
