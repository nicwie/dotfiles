import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: root
    Layout.preferredWidth: (content.implicitWidth > 0) ? content.implicitWidth + 20 : 1
    Layout.preferredHeight: child.implicitHeight
    Layout.alignment: Qt.AlignLeft
    Rectangle {
        id: child
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        color: AudioMonitor.audioColor
        implicitHeight: 30
        implicitWidth: parent.width + 1
        Text {
            id: content
            anchors.centerIn: parent
            property real volume: AudioMonitor.sinkVolume
            property bool muted: AudioMonitor.sinkMuted
            property bool ready: AudioMonitor.ready
            // font.pixelSize: 20
            text: getSinkText() + " " + getSourceText()

            function getSinkText() {
                if (ready) {
                    if (!muted) {
                        if (volume > 66) {
                            return "   " + volume + "%";
                        } else if (volume > 33) {
                            return "   " + volume + "%";
                        } else {
                            return "   " + volume + "%";
                        }
                    } else {
                        return "󰝟";
                    }
                } else {
                    return "";
                }
            }

            function getSourceText() {
                if (ready) {
                    if (AudioMonitor.sourceMuted) {
                        return "";
                    } else {
                        return "󰍬";
                    }
                } else {
                    return "";
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                // AudioMonitor.switchMute();
                sinkSlider.value = AudioMonitor.sinkVolume;
                sourceSlider.value = AudioMonitor.sourceVolume;
                audioPanel.visible = !audioPanel.visible;
            }
        }
        PopupWindow {
            id: audioPanel
            implicitWidth: mouseBackground.width + 5
            implicitHeight: mouseBackground.height + 5
            anchor {
                rect.y: root.height + 5
                // Find a better way for this (not moving too much when pressed, but staying ~ with the module)
                // rect.x: -(root.width / 2)
                item: root
                // adjustment: SlideY
            }
            color: "transparent"
            visible: false

            Rectangle {
                id: mouseBackground
                color: "transparent"
                implicitWidth: sliderRect.width + 80
                implicitHeight: sliderRect.height + 20
                MouseArea {
                    hoverEnabled: true
                    anchors {
                        fill: mouseBackground
                        centerIn: parent
                    }
                    width: sliderRect.width
                    height: sliderRect.height
                    onExited: {
                        audioPanel.visible = false;
                    }
                    Rectangle {
                        id: sliderRect
                        color: AudioMonitor.audioColor
                        // implicitWidth: sink.width + source.width + 10
                        implicitWidth: popout.width + 10
                        implicitHeight: ((sink.height + source.height) / 2) + 10
                        radius: 10
                        anchors.centerIn: parent
                        RowLayout {
                            id: popout
                            anchors.centerIn: parent

                            ColumnLayout {
                                id: sink
                                Slider {
                                    id: sinkSlider
                                    Layout.alignment: Qt.AlignHCenter
                                    orientation: Qt.Vertical

                                    background: Rectangle {
                                        x: sinkSlider.leftPadding
                                        y: sinkSlider.topPadding + sinkSlider.availableHeight / 2 - height / 2
                                        anchors.centerIn: sinkSlider
                                        implicitWidth: 4
                                        implicitHeight: 200
                                        width: implicitWidth
                                        height: sinkSlider.availableHeight
                                        radius: 2
                                        color: Colors.blue

                                        Rectangle {
                                            width: parent.width
                                            height: sinkSlider.visualPosition * parent.height
                                            color: "#bdbebf"
                                            radius: 2
                                        }
                                    }

                                    handle: Rectangle {
                                        y: sinkSlider.topPadding + sinkSlider.visualPosition * (sinkSlider.availableHeight - height)
                                        x: sinkSlider.leftPadding + sinkSlider.availableWidth / 2 - width / 2

                                        implicitHeight: 26
                                        implicitWidth: 26
                                        radius: 13
                                        color: sinkSlider.pressed ? "#f0f0f0" : "#f6f6f6"

                                        border.color: "#bdbebf"
                                    }

                                    from: 0
                                    to: 100

                                    onMoved: {
                                        AudioMonitor.setSinkVolume(value / 100);
                                    }
                                }
                                Button {
                                    id: muteSinkButton
                                    implicitWidth: 30
                                    contentItem: Text {
                                        text: muteSinkButton.text
                                        opacity: enabled ? 1.0 : 0.3
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        elide: Text.ElideRight
                                    }

                                    background: Rectangle {
                                        implicitWidth: 30
                                        implicitHeight: 30
                                        opacity: enabled ? 1 : 0.3
                                        border.width: 1
                                        radius: 5
                                    }
                                    text: {
                                        if (AudioMonitor.sinkMuted) {
                                            "󰝟";
                                        } else {
                                            "";
                                        }
                                    }
                                    onClicked: {
                                        AudioMonitor.switchSinkMute();
                                    }
                                }
                            }
                            ColumnLayout {
                                id: source
                                Slider {
                                    id: sourceSlider
                                    orientation: Qt.Vertical
                                    Layout.alignment: Qt.AlignHCenter

                                    background: Rectangle {
                                        x: sourceSlider.leftPadding
                                        y: sourceSlider.topPadding + sourceSlider.availableHeight / 2 - height / 2
                                        anchors.centerIn: sourceSlider
                                        implicitWidth: 4
                                        implicitHeight: 200
                                        width: implicitWidth
                                        height: sourceSlider.availableHeight
                                        radius: 2
                                        color: Colors.blue

                                        Rectangle {
                                            width: parent.width
                                            height: sourceSlider.visualPosition * parent.height
                                            color: "#bdbebf"
                                            radius: 2
                                        }
                                    }

                                    handle: Rectangle {
                                        y: sourceSlider.topPadding + sourceSlider.visualPosition * (sourceSlider.availableHeight - height)
                                        x: sourceSlider.leftPadding + sourceSlider.availableWidth / 2 - width / 2

                                        implicitHeight: 26
                                        implicitWidth: 26
                                        radius: 13
                                        color: sourceSlider.pressed ? "#f0f0f0" : "#f6f6f6"

                                        border.color: "#bdbebf"
                                    }

                                    from: 0
                                    to: 100

                                    onMoved: {
                                        AudioMonitor.setSourceVolume(value / 100);
                                    }
                                }
                                Button {
                                    id: muteSourceButton
                                    implicitWidth: 30
                                    contentItem: Text {
                                        text: muteSourceButton.text
                                        opacity: enabled ? 1.0 : 0.3
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        elide: Text.ElideRight
                                    }
                                    text: {
                                        if (AudioMonitor.sourceMuted) {
                                            "";
                                        } else {
                                            "󰍬";
                                        }
                                    }
                                    background: Rectangle {
                                        implicitWidth: 30
                                        implicitHeight: 30
                                        opacity: enabled ? 1 : 0.3
                                        border.width: 1
                                        radius: 5
                                    }
                                    onClicked: {
                                        AudioMonitor.switchSourceMute();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
