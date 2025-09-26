import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    Layout.preferredWidth: (content.implicitWidth > 0) ? content.implicitWidth + 20 : 0
    Layout.preferredHeight: child.implicitHeight
    Layout.alignment: Qt.AlignLeft
    Rectangle {
        id: child
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: WifiMonitor.wifiColor
        implicitHeight: 30
        width: parent.width + 1
        // implicitWidth: 120
        Text {
            id: content
            property string name: WifiMonitor.wifiName
            property int percent: WifiMonitor.wifiPercent
            anchors.centerIn: parent
            text: getDisplayText()
            function getDisplayText() {
                if (percent == 0) {
                    root.visible = false;
                    // console.log("name: " + name + "perc: " + percent);
                    return "";
                } else {
                    root.visible = true;
                    return name + " " + percent + "%";
                }
            }
        }
    }
}
