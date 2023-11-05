import QtQuick
import QtQuick.Window
import "variable.js" as Global

Item {
    Keys.onPressed: event => {
                        if (event.key === Qt.Key_Backspace) {
                            mainStack.pop()
                        }
                    }
    QtObject {
        id: dateObject
        property var locale: Qt.locale()
        property date currentTime: new Date()
        property string timeString
        property string listDate

        Component.onCompleted: {
            timeString = currentTime.toLocaleTimeString(locale,
                                                        Locale.ShortFormat)
            listDate = Date.fromLocaleTimeString(locale, timeString,
                                                 Locale.ShortFormat)
            let newListDate = listDate.split(' ')
            dateText.text = newListDate[1] + ' ' + newListDate[2]
            dayText.text = newListDate[0]
        }
    }
    Component.onCompleted: {
        backend.update_data(Global.cityName.toString())
        stateChanger.state = 'open'
    }
    BackgroundState {
        id: backgroundChanger
        target_id: backgroundImage
    }
    StateTransition {
        id: stateChanger
        targetId: mainRect
        targetId_2: backRectId
        heightValue: 400
    }

    Image {
        id: backgroundImage
        width: parent.width
        height: parent.height
        source: 'images/background_0.jpg'
        Rectangle {
            width: parent.width
            height: parent.height
            color: 'black'
            opacity: 0.3
        }
        Rectangle {
            id: backRectId
            anchors.centerIn: parent
            width: 500
            height: 400
            color: 'grey'
            opacity: 0.4
            z: 0
        }
    }
    Rectangle {
        id: mainRect
        width: 500
        height: 400
        border.color: 'white'
        color: 'transparent'
        border.width: 1
        anchors.centerIn: parent

        Item {
            width: parent.width
            height: parent.height / 5
            id: contentArea
            Text {
                id: cityId
                text: 'Bursa'
                font.pixelSize: 25
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
                color: 'white'
            }
            Text {
                id: countryText
                text: 'Turkey'
                font.pixelSize: 15
                anchors.top: cityId.bottom
                anchors.left: parent.left
                anchors.leftMargin: 10
                color: 'white'
            }

            Text {
                id: dateText
                text: ''
                font.pixelSize: 25
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
                color: 'white'
            }
            Text {
                id: dayText
                text: 'Monday'
                font.pixelSize: 15
                anchors.right: parent.right
                anchors.top: dateText.bottom
                anchors.rightMargin: 10
                color: 'white'
            }
        }

        LineComp {
            id: lineUpper
            anchors.top: contentArea.bottom
        }

        NewContainer {
            id: mainInfo
            anchors.top: lineUpper.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            Row {
                spacing: 40
                Text {
                    id: tempId
                    text: '35°C'
                    color: 'white'
                    font.pixelSize: 80
                }
                Image {
                    id: weatherImage
                    width: 100
                    height: 100
                    scale: 2
                }
            }
        }
        NewContainer {
            id: descriptionInfo
            anchors.top: mainInfo.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            Text {
                id: descriptionInfoText
                font.pixelSize: 30
                text: 'Desc'
                color: 'white'
            }
        }

        NewContainer {
            id: shortInfo
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: lineBottom.top
            Row {
                spacing: 40
                IconTextComp {
                    id: sunRise
                    textValue: ''
                    sourceValue: 'images/sunrise.png'
                }
                IconTextComp {
                    id: sunDown
                    textValue: ''
                    sourceValue: 'images/sunset.png'
                }
            }
        }

        LineComp {
            id: lineBottom
            width: 400
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: bottomLayer.top
            anchors.bottomMargin: 25
        }
        NewContainer {
            id: bottomLayer
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 30
            Row {
                id: rowId
                spacing: 35
                IconTextComp {
                    id: firstITC
                    textValue: ''
                    sourceValue: 'images/humudity.png'
                    anchors.left: bottomLayer.left
                }
                IconTextComp {
                    id: secondITC
                    textValue: ''
                    sourceValue: 'images/wind.png'
                    anchors.right: bottomLayer.right
                }
                IconTextComp {
                    id: thirdITC
                    textValue: ''
                    sourceValue: 'images/cloudiness.png'
                    anchors.centerIn: bottomLayer
                }
            }
        }
    }

    Connections {
        target: backend
        function onWeatherData(weather) {
            weatherImage.source = 'https://openweathermap.org/img/wn/' + weather[3] + '@2x.png'
            descriptionInfoText.text = weather[2]
            if (weather[1] === 'Clouds') {
                if (weather[3] === '02d' || weather[3] === '02n') {
                    backgroundChanger.state = 'fewclouds'
                } else {
                    backgroundChanger.state = 'cloudy'
                }
            } else if (weather[1] === 'Rain') {
                backgroundChanger.state = 'rainy'
            } else {
                backgroundChanger.state = 'sunny'
            }
        }
        function onMainData(main) {
            tempId.text = main[0].toFixed(1).toString() + '°C'
            firstITC.textValue = main[5].toFixed(0).toString() + '%'
        }
        function onWindData(wind) {
            secondITC.textValue = wind[0]
        }

        function onCloudData(clouds) {
            thirdITC.textValue = clouds[0] + '%'
        }
        function onCityData(city) {
            cityId.text = city
        }
        function onCountryData(country) {
            countryText.text = country
        }
        function onSunData(value) {
            sunRise.textValue = value[0]
            sunDown.textValue = value[1]
        }
    }
}
