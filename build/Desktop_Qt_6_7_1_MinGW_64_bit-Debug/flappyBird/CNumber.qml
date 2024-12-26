import QtQuick

Item {
    id: root

    property string inputText: ""

    width: blackText.width + 2

    Text {
        id: blackText

        text: root.inputText
        font{
            family: "04b_19"
            pixelSize: 60
        }
        color: "black"
        anchors{
            top: whiteText.top
            topMargin: 3
            left: whiteText.left
            leftMargin: 3
        }
    }
    Text {
        id: whiteText

        text: root.inputText
        font{
            family: "04b_19"
            pixelSize: 60
        }
        color: "white"
    }
}
