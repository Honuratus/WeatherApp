import QtQuick

Item {
    id: backgroundState
    property var target_id
    state: ''
    states: [
        State {
            name: 'cloudy'
            PropertyChanges {
                target: target_id
                source: 'images/background.jpg'
            }
        },
        State {
            name: 'fewclouds'
            PropertyChanges {
                target: target_id
                source: 'images/few_cloudy.jpg'
            }
        },
        State {
            name: 'sunny'
            PropertyChanges {
                target: target_id
                source: 'images/sun.jpg'
            }
        },
        State {
            name: 'rainy'
            PropertyChanges {
                target: target_id
                source: 'images/background_0.jpg'
            }
        }
    ]
}
