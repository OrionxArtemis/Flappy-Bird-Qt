import QtQuick
import QtQuick.Controls

Item {
    id: theBird

    property int baseThickness: 100
    property real fallSpeed: (window.height - theBird.baseThickness - theBird.height) / 3
    property bool isRunning: theLoader.isAnimationRunning
    property bool isStartRunning: false
    property int defaultTopMargin: 250

    function resetFallSpeed() {
        theBird.fallSpeed = Qt.binding(function() {return (window.height - theBird.baseThickness - theBird.height) / 3})
        fallSpeedUp.restart()
    }

    signal resetToDefault()

    width: 100
    height: theBird.width / (birdImage.sourceSize.width / birdImage.sourceSize.height)
    focus: true

    Image {
        id: birdImage

        anchors.fill: parent
        rotation: 0
        state: "move1"
        states: [
            State {
                name: "move1"
                PropertyChanges {
                    target: birdImage
                    source: "images/bird_move_1.png"
                }
            },
            State {
                name: "move2"
                PropertyChanges {
                    target: birdImage
                    source: "images/bird_move_2.png"
                }
            },
            State {
                name: "move3"
                PropertyChanges {
                    target: birdImage
                    source: "images/bird_move_3.png"
                }
            }
        ]

        // Animation of making the bird's head up and down smoothly
        Behavior on rotation {
            id: rotateAnimation

            SequentialAnimation {
                NumberAnimation {  
                    duration: fallingTimer.isFalling ? 400 : 200
                    easing.type: Easing.OutQuad
                }
                ScriptAction {
                    script: fallingTimer.isFalling = false
                }
            }
        }
    }

    // Pressing a key will hold the bird's head up as well as start/reset/stop some timers
    Keys.onPressed: {
        if (theBird.isRunning === true) {
            if (popupLoader.source !== "") {
                popupLoader.source = ""
            }
            soundManager.swooshingSound.stop()
            fallAnimation.stop()
            flyAnimation.start()
            birdImage.rotation = -20
            theBird.resetFallSpeed()
            flappingTimer.start()
            fallingTimer.restart()
            keyHoldingTimer.restart()
            soundManager.swooshingSound.play()
        }
    }

    // Set limits of the bird's flying height
    onYChanged: {
        if (theBird.anchors.topMargin < 0) {
            theBird.anchors.topMargin = 0
        }
        else if (theBird.anchors.topMargin >= window.height - theBird.baseThickness - theBird.height) {
            fallAnimation.stop()
        }
    }

    // Keep the bird in height 250 while showing waiting screen
    onResetToDefault: {
        theBird.anchors.topMargin = theBird.defaultTopMargin
        birdImage.rotation = 0
        flyAnimation.stop()
        fallAnimation.stop()
        fallingTimer.stop()
    }

    // Stop all animations when pause button is pressed and restart them when continue button is pressed
    onIsRunningChanged: {
        if (theBird.isStartRunning === true) {
            if (theBird.isRunning === false) {
                rotateAnimation.enabled = false
                fallAnimation.stop()
                flyAnimation.stop()
                fallSpeedUp.stop()
                flappingTimer.stop()
                fallingTimer.stop()
            } else {
                rotateAnimation.enabled = true
                fallAnimation.restart()
                flyAnimation.restart()
                fallSpeedUp.restart()
                flappingTimer.restart()
                fallingTimer.restart()
            }
        } else {
            theBird.isStartRunning = true
        }
    }

    // Animation of the bird's falling after not pressing any keys
    NumberAnimation on anchors.topMargin {
        id: fallAnimation

        running: false
        to: window.height - theBird.baseThickness - theBird.height
        duration: ((window.height - theBird.baseThickness - theBird.anchors.topMargin - theBird.height) / theBird.fallSpeed) * 1000
    }

    // Animation of the bird's flying after pressing a key
    NumberAnimation on anchors.topMargin {
        id: flyAnimation

        running: false
        to: keyHoldingTimer.running === false ? theBird.anchors.topMargin - 50 : theBird.anchors.topMargin - 150
        duration: 500
        easing.type: Easing.OutQuad
        onFinished: fallAnimation.start()
    }

    // Animation of increasing the fall speed smooothly
    NumberAnimation on fallSpeed {
        id: fallSpeedUp

        to: 750
        duration: 800
        easing.type: Easing.InQuad
    }

    // Timer of changing movements of the bird
    Timer {
        id: flappingTimer

        interval: 100
        repeat: true
        running: true

        onTriggered: {
            switch (birdImage.state) {
                case "move1": {
                    birdImage.state = "move2"
                    break
                }
                case "move2": {
                    birdImage.state = "move3"
                    break
                }
                case "move3": {
                    birdImage.state = "move1"
                    break
                }
                default: break
            }
        }
    }

    // Timer after not pressing any keys
    Timer {
        id: fallingTimer

        property bool isFalling: false

        interval: 800
        running: false
        onTriggered: {
            fallingTimer.isFalling = true
            flappingTimer.stop()
            birdImage.state = "move2"
            birdImage.rotation = 90
        }
    }

    // Time of holding a key to let the bird fly higher
    Timer {
        id: keyHoldingTimer

        interval: 100
    }
}
