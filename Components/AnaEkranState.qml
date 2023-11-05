import QtQuick

Item {
    id: bgState
    property var target_id
    property var target_id2
    property var target_id3
    state: 'first'
    states: [
        State {
            name: 'first'
            PropertyChanges {
                target: target_id
                opacity: 1
            }
            PropertyChanges {
                target: target_id2
                opacity: 0
            }
            PropertyChanges {
                target: target_id3

                opacity: 0
            }
        },
        State {
            name: 'second'
            PropertyChanges {
                target: target_id
                opacity: 0
            }
            PropertyChanges {
                target: target_id2
                opacity: 1
            }
            PropertyChanges {
                target: target_id3

                opacity: 0
            }
        },
        State {
            name: 'third'
            PropertyChanges {
                target: target_id
                opacity: 0
            }
            PropertyChanges {
                target: target_id2
                opacity: 0
            }
            PropertyChanges {
                target: target_id3

                opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            from: 'first'
            to: 'second'
            PropertyAnimation {
                duration: 500
                properties: 'opacity'
            }
        },
        Transition {
            from: 'second'
            to: 'third'
            PropertyAnimation {
                duration: 500
                properties: 'opacity'
            }
        },
        Transition {
            from: 'third'
            to: 'first'
            PropertyAnimation {
                duration: 500
                properties: 'opacity'
            }
        }
    ]

    Timer {
        interval: 5000
        repeat: true
        running: true
        onTriggered: {
            if (bgState.state === 'first') {
                bgState.state = 'second'
                console.log('second')
            } else if (bgState.state === 'second') {
                bgState.state = 'third'
                console.log('third')
            } else {
                bgState.state = 'first'
                console.log('first')
            }
        }
    }
}
