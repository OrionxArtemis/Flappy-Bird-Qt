import QtQuick

Item {
    id: boardText

    property string text: ""

    Text {
        id: whiteText

        text: boardText.text
        color: "white"
        font{
            family: "QuinqueFive"
            pixelSize: 20
        }
        anchors{
            top: brownText.top
            topMargin: 1
            left: brownText.left
            leftMargin: 1
        }
    }
    Text {
        id: brownText

        text: boardText.text
        color: "brown"
        anchors.horizontalCenter: parent.horizontalCenter

        font{
            // https://ggbot.itch.io/quinquefive-font
            family: "QuinqueFive"
            pixelSize: 20
        }
    }
}
