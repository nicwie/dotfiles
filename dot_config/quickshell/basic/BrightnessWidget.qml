import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: root
    Layout.preferredWidth: child.implicitWidth
    Layout.preferredHeight: child.implicitHeight
    Layout.alignment: Qt.AlignRight
    Rectangle {
        id: child
        anchors.fill: parent
        color: BrightnessMonitor.brightnessColor
        implicitHeight: 30
        implicitWidth: 60
        Text {
            property real brightnessPercent: BrightnessMonitor.brightnessPercent
            anchors.centerIn: parent
            text: getBrightnessString()
            function getBrightnessString() {
                // Would love to use a switch statement here, but don't know if those exist
                var icon;
                if (brightnessPercent > 90) {
                    icon = "";
                } else if (brightnessPercent > 80) {
                    icon = "";
                } else if (brightnessPercent > 70) {
                    icon = "";
                } else if (brightnessPercent > 70) {
                    icon = "";
                } else if (brightnessPercent > 60) {
                    icon = "";
                } else if (brightnessPercent > 50) {
                    icon = "";
                } else if (brightnessPercent > 40) {
                    icon = "";
                } else if (brightnessPercent > 30) {
                    icon = "";
                } else if (brightnessPercent > 20) {
                    icon = "";
                } else {
                    icon = "";
                }
                return icon + "  " + brightnessPercent + "%";
            }
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                brightnessSlider.value = BrightnessMonitor.brightnessPercent;
                brightnessPanel.visible = !brightnessPanel.visible;
            }
        }
        PopupWindow {
            id: brightnessPanel
            implicitWidth: mouseBackground.width + 5
            implicitHeight: mouseBackground.height + 5
            anchor.rect.y: root.height + 5
            anchor.item: root
            color: "transparent"
            visible: false

            // This is so that the are where the popup stays visible is larger than the slider rectangle area
            Rectangle {
                id: mouseBackground
                color: "transparent"
                implicitWidth: sliderRect.width + 40
                implicitHeight: sliderRect.height
                MouseArea {
                    hoverEnabled: true
                    anchors {
                        fill: mouseBackground
                        centerIn: parent
                    }
                    width: sliderRect.width
                    height: sliderRect.height
                    onExited: {
                        brightnessPanel.visible = false;
                    }

                    Rectangle {
                        id: sliderRect
                        color: BrightnessMonitor.brightnessColor
                        implicitWidth: brightnessSlider.width + 10
                        implicitHeight: brightnessSlider.height + 10
                        radius: 10
                        anchors.centerIn: parent

                        Slider {
                            id: brightnessSlider
                            orientation: Qt.Vertical
                            anchors.centerIn: sliderRect

                            background: Rectangle {
                                x: brightnessSlider.leftPadding
                                y: brightnessSlider.topPadding + brightnessSlider.availableHeight / 2 - height / 2
                                anchors.centerIn: brightnessSlider
                                implicitWidth: 4
                                implicitHeight: 200
                                width: implicitWidth
                                height: brightnessSlider.availableHeight
                                radius: 2
                                color: "#21be2b"

                                Rectangle {
                                    width: parent.width
                                    height: brightnessSlider.visualPosition * parent.height
                                    color: "#bdbebf"
                                    radius: 2
                                }
                            }

                            handle: Rectangle {
                                y: brightnessSlider.topPadding + brightnessSlider.visualPosition * (brightnessSlider.availableHeight - height)
                                x: brightnessSlider.leftPadding + brightnessSlider.availableWidth / 2 - width / 2

                                implicitHeight: 26
                                implicitWidth: 26
                                radius: 13
                                color: brightnessSlider.pressed ? "#f0f0f0" : "#f6f6f6"

                                border.color: "#bdbebf"
                            }

                            from: 0
                            to: 100

                            onMoved: BrightnessMonitor.setBrightness(value)
                        }
                    }
                }
            }
        }
    }
}
