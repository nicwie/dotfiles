import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

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

                    onClicked: event => {
                        if (event.button === Qt.LeftButton)
                            modelData.activate();
                        else
                            modelData.secondaryActivate();
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
                        // colour: Colours.palette.m3secondary
                        // layer.enabled: Config.bar.tray.recolour
                    }
                }
            }
        }
    }
}
