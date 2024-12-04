import QtQuick
import com.flappyBird.backend 1.0

Item {
    anchors.fill: parent

    Image {
        id: gameOverText

        source: "Image/GameOver.png"
        anchors.horizontalCenter: parent.horizontalCenter
        height: 150
        width: window.calWidthFollowHeight(gameOverText)

        NumberAnimation on y {
            running: true
            from: 0
            to: 100
            duration: 500
            easing.type: Easing.OutQuad
        }
    }

    Image {
        id: yourScoreBoard

        source: "Image/scoreboard.png"
        anchors.horizontalCenter: parent.horizontalCenter
        height: 250
        width: window.calWidthFollowHeight(yourScoreBoard)

        Row {
            anchors{
                top: parent.top
                topMargin: 70
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 90

            Item {
                width: 100
                height: 80

                BoardText {
                    text: "SCORE"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                CNumber{
                    inputText: Backend.getPoint
                    anchors{
                        top: parent.top
                        topMargin: 30
                        horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            Item {
                width: 100
                height: 80

                BoardText {
                    text: "BEST"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                CNumber{
                    inputText: Backend.getBestScore()
                    anchors{
                        top: parent.top
                        topMargin: 30
                        horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }

        NumberAnimation on y {
            running: true
            from: window.height - theBase.height
            to: 300
            duration: 500
            easing.type: Easing.OutQuad
        }
    }

    Row {
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 150
        }
        spacing: 30

        TemplateButton {
            id: restartButton

            height: 80
            type: 1
            text: "RESTART"
            fontSize: 20

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    theLoader.isAnimationRunning = true
                    popupLoader.source = "ReadyScreen.qml"
                    screenLoader.source = "GameScreen.qml"
                    screenLoader.item.resetBirdToDefault()
                }
            }
        }

        TemplateButton {
            id: menuButton

            height: 80
            type: 1
            text: "MENU"
            fontSize: 20

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    theLoader.isAnimationRunning = true
                    popupLoader.source = ""
                    screenLoader.source = "HomeScreen.qml"
                }
            }
        }

        NumberAnimation on opacity {
            running: true
            from: 0
            to: 1
            duration: 500
            easing.type: Easing.InQuad
        }
    }
}
