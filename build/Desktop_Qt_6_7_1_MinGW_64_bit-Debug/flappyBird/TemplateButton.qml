import QtQuick

Item {
    id: templateButton

    property string text: ""
    property int fontSize: 28
    property int type: 1

    width: (templateButton.type === 1) ? type1Button.width :  type2Button.width

    Image {
        id: type1Button

        source: "Image/templateButton.png"
        height: templateButton.height
        width: window.calWidthFollowHeight(type1Button)
        visible: (templateButton.type === 1) ? true : false

        Text {
            id: blackPixelText

            text: templateButton.text
            font{
                family: "QuinqueFive"
                pixelSize: templateButton.fontSize
            }
            color: "black"
            anchors{
                top: whitePixelText.top
                topMargin: 1
                left: whitePixelText.left
                leftMargin: 1
            }
        }
        Text {
            id: whitePixelText

            anchors.centerIn: parent
            text: templateButton.text
            font{
                // https://ggbot.itch.io/quinquefive-font
                family: "QuinqueFive"
                pixelSize: templateButton.fontSize
            }
            color: "white"
        }
    }

    Image {
        id: type2Button

        source: "Image/squareButton.png"
        height: templateButton.height
        width: window.calWidthFollowHeight(type2Button)
        visible: (templateButton.type === 2) ? true : false

        Image {
            id: muteButton

            source: "Image/mute.png"
            anchors.centerIn: parent
            height: type2Button.height - 30
            width: window.calWidthFollowHeight(muteButton)
            visible: (soundManager.isMuted === false) ? true : false

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    soundManager.isMuted = true
                }
            }
        }

        Image {
            id: unmuteButton

            source: "Image/unmute.png"
            anchors.centerIn: parent
            height: type2Button.height - 30
            width: window.calWidthFollowHeight(unmuteButton)
            visible: (soundManager.isMuted === true) ? true : false

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    soundManager.isMuted = false
                }
            }
        }
    }
}
