// Delimiter.qml
import QtQuick
import QtQuick.Layouts

Rectangle {
    property color backgroundColor: "transparent"
    property color foregroundColor: "white"
    property string symbol: ""

    implicitWidth: symbolText.implicitWidth + 10
    implicitHeight: symbolText.implicitHeight
    Layout.preferredHeight: 30

    color: backgroundColor

    Text {
        id: symbolText
        anchors.left: parent
        anchors.verticalCenter: parent
        text: symbol
        color: foregroundColor
        font.pixelSize: 22
    }
}
