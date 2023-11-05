import QtQuick
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("WeatherApp")
    color: 'black'

    StackView {
        id: mainStack
        anchors.fill: parent
        initialItem: AnaEkran {}
    }
}
