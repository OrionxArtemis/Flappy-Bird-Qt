import QtQuick
import com.flappyBird.backend 1.0

Item {
    id: thePipe

    readonly property int pipeSpace: 250
    readonly property int borderWidth: 3
    readonly property real runningSpeed: ((gameScreen.width + 100) - (-100)) / 15000
    property bool isRunning: theLoader.isAnimationRunning && !gameScreen.isWaitingPressed
    property var pipeContainer: []

    function destroyAllPipes() {
        if (thePipe.pipeContainer.length != 0) {
            do {
                thePipe.pipeContainer[0].top.destroy()
                thePipe.pipeContainer[0].topManhole.destroy()
                thePipe.pipeContainer[0].bottom.destroy()
                thePipe.pipeContainer[0].bottomManhole.destroy()
                thePipe.pipeContainer.shift()
            } while (thePipe.pipeContainer.length != 0)
        }
    }

    function isTouchedTheBird(pipe) {
        return (theBird.x + theBird.width > pipe.x) &&
               (pipe.x + pipe.width > theBird.x) &&
               (theBird.y + theBird.height > pipe.y) &&
               (pipe.y + pipe.height > theBird.y)
    }

    signal touchTheBird() 

    Component {
        id: topPipeCreator

        Rectangle {
            id: topPipe

            property bool bountyPoint: true

            gradient: pipeColor
            border{
                color: "black"
                width: thePipe.borderWidth
            }

            PropertyAnimation on x {
                id: topPipeRunningAnimation

                running: thePipe.isRunning
                to: -100
                duration: (topPipe.x - topPipeRunningAnimation.to) / thePipe.runningSpeed
                easing.type: Easing.Linear
                onFinished: {
                    // Delete top pipes goes outside from the screen
                    thePipe.pipeContainer[0].top.destroy()
                }
            }

            onXChanged: {
                if (thePipe.isTouchedTheBird(this)) {
                    thePipe.touchTheBird()
                } else if (topPipe.bountyPoint === true) {
                    if (((theBird.x + theBird.width) >= (this.x + this.width)) && ((theBird.x) <= (this.x + this.width))) {
                        topPipe.bountyPoint = false
                        Backend.addPoint()
                    }
                }
            }
        }
    }

    Component {
        id: topManholeCreator

        Rectangle {
            id: topManhole

            gradient: pipeColor
            border{
                color: "black"
                width: thePipe.borderWidth
            }

            PropertyAnimation on x {
                id: topManholeRunningAnimation

                running: thePipe.isRunning
                to: -110
                duration: (topManhole.x - topManholeRunningAnimation.to) / thePipe.runningSpeed
                easing.type: Easing.Linear
                onFinished: {
                    // Delete top manholes goes outside from the screen
                    thePipe.pipeContainer[0].topManhole.destroy()
                }
            }

            onXChanged: {
                if (thePipe.isTouchedTheBird(this)) {
                    thePipe.touchTheBird()
                }
            }
        }
    }

    Component {
        id: bottomPipeCreator

        Rectangle {
            id: bottomPipe

            gradient: pipeColor
            border{
                color: "black"
                width: thePipe.borderWidth
            }

            PropertyAnimation on x {
                id: bottomPipeRunningAnimation

                running: thePipe.isRunning
                to: -100
                duration: (bottomPipe.x - bottomPipeRunningAnimation.to) / thePipe.runningSpeed
                easing.type: Easing.Linear
                onFinished: {
                    // Delete bottom pipes goes outside from the screen
                    thePipe.pipeContainer[0].bottom.destroy()
                }
            }

            onXChanged: {
                if (thePipe.isTouchedTheBird(this)) {
                    thePipe.touchTheBird()
                }
            }
        }
    }

    Component {
        id: bottomManholeCreator

        Rectangle {
            id: bottomManhole

            gradient: pipeColor
            border{
                color: "black"
                width: thePipe.borderWidth
            }

            PropertyAnimation on x {
                id: bottomManholeRunningAnimation

                running: thePipe.isRunning
                to: -110
                duration: (bottomManhole.x - bottomManholeRunningAnimation.to) / thePipe.runningSpeed
                easing.type: Easing.Linear
                onFinished: {
                    // Delete bottom manholes goes outside from the screen and remove the first element of pipeContainer
                    thePipe.pipeContainer[0].bottomManhole.destroy()
                    thePipe.pipeContainer.shift()
                }
            }

            onXChanged: {
                if (thePipe.isTouchedTheBird(this)) {
                    thePipe.touchTheBird()
                }
            }
        }
    }

    Gradient {
        id: pipeColor

        orientation: Gradient.Horizontal

        GradientStop {
            position: 0.0
            color: "green"
        }
        GradientStop {
            position: 0.3
            color: "chartreuse"
        }
        GradientStop {
            position: 0.7
            color: "limegreen"
        }
        GradientStop {
            position: 1.0
            color: "green"
        }
    }

    Timer {
        id: pipeCreatingTimer

        interval: 4000
        running: thePipe.isRunning
        repeat: true
        onTriggered: {
            var oneTopPipe = topPipeCreator.createObject(parent,
               {"x": gameScreen.width + 100,
                "y": 0,
                "width": 90,
                "height": Math.random() * (window.height - (thePipe.pipeSpace + 100) - 50) + 50})

            var onetopManhole = topManholeCreator.createObject(parent,
               {"x": oneTopPipe.x - 10,
                "y": oneTopPipe.height - thePipe.borderWidth - 1,
                "width": oneTopPipe.width + 20,
                "height": 36})

            var oneBottomPipe = bottomPipeCreator.createObject(parent,
               {"x": oneTopPipe.x,
                "y": oneTopPipe.y + oneTopPipe.height + thePipe.pipeSpace,
                "width": oneTopPipe.width,
                "height": gameScreen.height - theBase.height - oneTopPipe.height - thePipe.pipeSpace + 50})

            var oneBottomManhole = bottomManholeCreator.createObject(parent,
               {"x": oneBottomPipe.x - 10,
                "y": oneBottomPipe.y - 36 + thePipe.borderWidth,
                "width": oneBottomPipe.width + 20,
                "height": 36})

            thePipe.pipeContainer.push({top: oneTopPipe, topManhole: onetopManhole, bottom: oneBottomPipe, bottomManhole: oneBottomManhole})
        }
    }
}
