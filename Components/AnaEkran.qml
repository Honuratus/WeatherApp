import QtQuick
import QtQuick.Controls
import "variable.js" as Global

Item {
    AnaEkranState {
        target_id: bgImage
        target_id2: bgImage1
        target_id3: bgImage2
    }
    Keys.onPressed: event => {
                        if (event.key === Qt.Key_Shift) {
                            Global.cityName = textCityInput.text
                            mainStack.push('main.qml')
                        }
                    }

    property int control: 0
    id: mainContainer
    Image {
        id: bgImage
        width: parent.width
        height: parent.height
        source: '../images/prague.jpg'
        Rectangle {
            width: parent.width
            height: parent.height
            opacity: 0.4
            color: 'black'
        }
    }
    Image {
        id: bgImage1
        width: parent.width
        height: parent.height
        source: '../images/budapest.jpg'
        Rectangle {
            width: parent.width
            height: parent.height
            opacity: 0.4
            color: 'black'
        }
    }
    Image {
        id: bgImage2
        width: parent.width
        height: parent.height
        source: '../images/istanbul.jpg'
        Rectangle {
            width: parent.width
            height: parent.height
            opacity: 0.4
            color: 'black'
        }
    }
    NewContainer {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 30
        Text {
            id: mainTitle
            text: 'Hos Geldiniz'
            font.pixelSize: 80
            color: 'white'
            Text {
                id: mainInfo
                text: 'Ozgur Yazilim Kampi Hava Durumu Projesi'
                font.pixelSize: 20
                anchors.top: mainTitle.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: 'white'
            }
        }
    }
    NewContainer {
        anchors.centerIn: parent
        id: cityInput
        TextField {
            id: textCityInput
            width: 200
            height: 30
            mouseSelectionMode: TextInput.SelectWords
            placeholderText: qsTr('Sehir')
            background: Rectangle {
                width: 200
                height: 30
                radius: width
                border.color: 'white'
                border.width: 1
            }
        }
    }

    Button {
        id: mainButtin
        width: childrenRect.width
        height: childrenRect.height

        anchors.top: cityInput.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

        background: Rectangle {
            width: 100
            height: 30
            color: 'black'
            radius: width
            Rectangle {
                id: glowButton
                width: 100
                height: 30
                radius: width
                anchors.centerIn: parent
                opacity: 0.4
                gradient: Gradient {
                    GradientStop {
                        id: gradientStop1
                        position: 0.0
                        color: "white"
                    }
                    GradientStop {
                        id: gradientStop2
                        position: 0.50
                        color: "black"
                    }
                    GradientStop {
                        id: gradientStop3
                        position: 1.0
                        color: "black"
                    }
                }
                border.color: 'white'
                border.width: 1

                AnimatedButton {}
            }

            Text {
                anchors.centerIn: parent
                text: 'Ara'
                color: 'white'
            }
        }
        onClicked: {
            Global.cityName = textCityInput.text
            mainStack.push('main.qml')
        }
    }
    Item {
        state: 'close'
        id: stateChanger
        states: [
            State {
                name: 'close'
                PropertyChanges {
                    target: mainContainer
                    opacity: 0
                }
            },
            State {
                name: 'open'
                PropertyChanges {
                    target: mainContainer
                    opacity: 1
                }
            }
        ]

        transitions: [
            Transition {
                from: 'close'
                to: 'open'

                PropertyAnimation {
                    duration: 300
                    properties: 'opacity'
                }
            }
        ]
        Timer {
            interval: 10
            repeat: false
            running: true
            onTriggered: {
                stateChanger.state = 'open'
            }
        }
    }
}
