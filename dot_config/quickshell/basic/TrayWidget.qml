import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Services.SystemTray

Item {
    id: root
    Layout.preferredWidth: background.width
    Layout.preferredHeight: background.height
    Layout.alignment: Qt.AlignLeft

    Rectangle {
        id: background
        color: Colors.maroon
        implicitWidth: (content.width > 0) ? content.width + 10 : 3
        implicitHeight: 30
        Row {
            id: content
            anchors.centerIn: parent
            spacing: 10
            Repeater {
                id: items
                model: SystemTray.items

                MouseArea {
                    id: iconRoot

                    required property SystemTrayItem modelData

                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    implicitWidth: 20
                    implicitHeight: 20

                    onClicked: mouse => {
                        var mappedPoint = iconRoot.mapToItem(null, mouse.x, mouse.y);
                        if (mouse.button === Qt.LeftButton) {
                            modelData.activate();
                        } else if (mouse.button === Qt.RightButton && modelData.hasMenu) {
                            modelData.display(background, background.x + 5, background.y);
                        } else {
                            modelData.secondaryActivate();
                        }
                    }

                    Image {
                        id: icon

                        anchors.fill: parent
                        source: {
                            let icon = iconRoot.modelData.icon;
                            if (icon.includes("?path=")) {
                                const [name, path] = icon.split("?path=");
                                icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
                            }
                            return icon;
                        }
                    }
                }
            }
        }
    }
}
