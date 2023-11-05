import QtQuick

Item {
    property int durationValue: 1000
    id: buttonState
    state: 'first'
    states: [
        State {
            name: 'first'
            PropertyChanges {
                target: gradientStop1
                color: 'white'
            }
            PropertyChanges {
                target: gradientStop2
                color: 'black'
            }
            PropertyChanges {
                target: gradientStop3
                color: 'black'
            }
        },
        State {
            name: 'second'
            PropertyChanges {
                target: gradientStop1
                color: 'black'
            }
            PropertyChanges {
                target: gradientStop2
                color: 'white'
            }
            PropertyChanges {
                target: gradientStop3
                color: 'black'
            }
        },
        State {
            name: 'third'
            PropertyChanges {
                target: gradientStop1
                color: 'black'
            }
            PropertyChanges {
                target: gradientStop2
                color: 'black'
            }
            PropertyChanges {
                target: gradientStop3
                color: 'white'
            }
        }
    ]

    transitions: [
        Transition {
            from: 'first'
            to: 'second'
            PropertyAnimation {
                target: gradientStop1
                properties: 'color'
                duration: durationValue
            }
            PropertyAnimation {
                target: gradientStop2
                properties: 'color'
                duration: durationValue
            }
            PropertyAnimation {
                target: gradientStop3
                properties: 'color'
                duration: durationValue
            }
        },
        Transition {
            from: 'second'
            to: 'third'
            PropertyAnimation {
                target: gradientStop1
                properties: 'color'
                duration: durationValue
            }
            PropertyAnimation {
                target: gradientStop2
                properties: 'color'
                duration: durationValue
            }
            PropertyAnimation {
                target: gradientStop3
                properties: 'color'
                duration: durationValue
            }
        },
        Transition {
            from: 'third'
            to: 'first'
            PropertyAnimation {
                target: gradientStop1
                properties: 'color'
                duration: durationValue
            }
            PropertyAnimation {
                target: gradientStop2
                properties: 'color'
                duration: durationValue
            }
            PropertyAnimation {
                target: gradientStop3
                properties: 'color'
                duration: durationValue
            }
        }
    ]

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            if (buttonState.state === 'first') {
                buttonState.state = 'second'
            } else if (buttonState.state === 'second') {
                buttonState.state = 'third'
            } else {
                buttonState.state = 'first'
            }
        }
    }
}
