import QtQuick

Item {
    id: stateChanger
    property var targetId
    property var targetId_2
    property var targetId_3
    property int heightValue: 0
    state: 'close'
    states: [
        State {
            name: 'close'
            PropertyChanges {
                target: targetId
                height: 0
                visible: visibleChildren.lenght > 0
            }
            PropertyChanges {
                target: targetId_2
                height: 0
            }
        },
        State {
            name: 'open'
            PropertyChanges {
                target: targetId
                height: heightValue
            }
            PropertyChanges {
                target: targetId_2
                height: heightValue
            }
        }
    ]

    transitions: [
        Transition {
            from: 'close'
            to: 'open'

            PropertyAnimation {
                properties: 'height'
                duration: 400
            }
        }
    ]
}
