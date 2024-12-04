import QtQuick

Item {
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        opacity: 0.3
        color: "black"
    }

    Column {
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 100
        }
        spacing: 70

        Image {
            id: getReadyText

            source: "Image/GetReady.png"
            height: 150
            width: window.calWidthFollowHeight(getReadyText)
        }

        Image {
            id: instruction

            source: "Image/instruction.png"
            anchors.horizontalCenter: parent.horizontalCenter
            height: 300
            width: window.calWidthFollowHeight(instruction)
        }
    }

    Row {
        x: 10
        y: 10
        z: 1
        spacing: 10

        Image {
            id: pauseButton

            source: "Image/pauseButton.png"
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
