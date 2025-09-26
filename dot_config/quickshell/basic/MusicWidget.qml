import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

Item {
    id: root
    Layout.preferredWidth: content.implicitWidth
    Layout.preferredHeight: content.implicitHeight

    Layout.alignment: Qt.AlignCenter

    Rectangle {
        color: Colors.teal
        anchors.centerIn: parent
        ColumnLayout {
            spacing: 0
            anchors.centerIn: parent
            Rectangle {
                id: content
                Layout.alignment: Qt.AlignVCenter
                implicitHeight: 30
                implicitWidth: trackTitle.width
                color: "transparent"
                Text {
                    id: trackTitle
                    anchors.centerIn: parent
                    font.pixelSize: 18
                    text: MusicMonitor.title + " - " + MusicMonitor.artist
                }
            }
            Rectangle {
                id: control
                implicitHeight: 10
                color: "transparent"
                implicitWidth: musicProgress.implicitWidth
                Layout.alignment: Qt.AlignVCenter
                ProgressBar {
                    id: musicProgress
                    from: 0
                    to: 1
                    value: MusicMonitor.trackProgress
                    indeterminate: (value != 0) ? false : true
                    background: Rectangle {
                        implicitWidth: content.width
                        implicitHeight: 4
                        color: "#e6e6e6"
                        radius: 3
                    }
                    contentItem: Item {
                        implicitWidth: content.width
                        implicitHeight: 4

                        Rectangle {
                            width: musicProgress.visualPosition * parent.width
                            height: parent.height
                            radius: 2
                            color: "#17a81a"
                            visible: !musicProgress.indeterminate
                        }

                        Item {
                            anchors.fill: parent
                            visible: musicProgress.indeterminate
                            clip: true
                            Row {
                                spacing: 20

                                Repeater {
                                    model: musicProgress.width / 40 + 1

                                    Rectangle {
                                        color: "#17a81a"
                                        width: 20
                                        height: musicProgress.height
                                    }
                                }
                                XAnimator on x {
                                    from: -20
                                    to: 20
                                    loops: Animation.Infinite
                                    running: musicProgress.indeterminate
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
