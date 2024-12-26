import QtQuick
import QtQuick.Controls
import com.flappyBird.backend 1.0

Rectangle{
    id: gameScreen

    property bool isWaitingPressed: true

    signal resetBirdToDefault()

    function gameOver() {
        theLoader.isAnimationRunning = false
        soundManager.hitSound.play()
        soundManager.dieSound.play()
        if (parseInt(Backend.getPoint) > parseInt(Backend.getBestScore())) {
            Backend.saveBestScore(Backend.getPoint);
            console.log("Added new best score: " + Backend.getPoint)
        }
        popupLoader.source = "GameOverScreen.qml"
    }

    anchors.fill: parent
    color: "transparent"

    onResetBirdToDefault: {
        gameScreen.isWaitingPressed = true
        theBird.resetToDefault()
        thePipes.destroyAllPipes()
    }

    CNumber{
        inputText: Backend.getPoint
        anchors{
            top: parent.top
            topMargin: 120
            horizontalCenter: parent.horizontalCenter
        }
        z: 1
        visible: (popupLoader.source == "GameOverScreen.qml") ? false : true
    }

    Pipe {
        id: thePipes

        anchors{
            top: parent.top
            topMargin: -thePipes.borderWidth
        }
        onTouchTheBird: {
            gameScreen.gameOver()
        }
    }

    Bird {
        id: theBird

        anchors{
            top: parent.top
            topMargin: theBird.defaultTopMargin
            left: parent.left
            leftMargin: 400
        }
        z: 1
        baseThickness: theBase.height
        Keys.onPressed: {
            gameScreen.isWaitingPressed = false
        }
        onYChanged: {
            if (theBird.y + theBird.height >= theBase.y) {
                gameScreen.gameOver()
            }
        }
    }

    Row {
        id: settingButtons

        x: 10
        y: 10
        z: 1
        spacing: 10
        visible: (popupLoader.source == "GameOverScreen.qml") ? false : true

        Image {
            id: pauseButton

            source: "images/pauseButton.png"
            height: 50
            width: window.calWidthFollowHeight(pauseButton)

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    theLoader.isAnimationRunning = false
                    popupLoader.source = "PauseScreen.qml"
                }
            }
        }

        TemplateButton {
            id: muteButton

            type: 2
            height: 50
        }
    }
}

