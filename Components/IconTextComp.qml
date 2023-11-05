import QtQuick

NewContainer {
    //    property string textId: 'Default'
    //    property string rectId: 'Default'
    property string textValue: 'Default'
    property string sourceValue: 'Default'
    Text {
        id: textId
        text: textValue
        font.pixelSize: 35
        color: 'white'
        anchors.left: rectId.right
        anchors.leftMargin: 10
    }
    Image {
        id: rectId
        width: 35
        height: 35
        source: sourceValue
    }
}
