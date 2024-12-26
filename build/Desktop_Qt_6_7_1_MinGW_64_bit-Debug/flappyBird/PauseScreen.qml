import QtQuick

Item {
    anchors.fill: parent

    Rectangle{
        anchors.fill: parent
        opacity: 0.5
        color: "black"
    }

    Row {
        x: 10
        y: 10
        spacing: 10

        Image {
            id: continueButton

            source: "Image/continueButton.png"
            height: 50
            width: window.calWidthFollowHeight(continueButton)

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    theLoader.isAnimationRunning = true
                    popupLoader.source = ""
                }
            }
        }

        TemplateButton {
            id: muteButton

            type: 2
            height: 50
        }
    }

    Row {
        anchors.centerIn: parent
        spacing: 30

        TemplateButton {
            id: restartButton

            height: 100
            text: "RESTART"
            type: 1

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    theLoader.isAnimationRunning = true
                    popupLoader.source = "ReadyScreen.qml"
                    screenLoader.item.resetBirdToDefault()
                }
            }
        }

        TemplateButton {
            id: menuButton

            height: 100
            text: "MENU"
            type: 1

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    theLoader.isAnimationRunning = true
                    popupLoader.source = ""
                    screenLoader.source = "HomeScreen.qml"
                }
            }
        }
    }
}
