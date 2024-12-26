import QtQuick
import QtQuick.Controls

Rectangle {
    width: 500
    height: 300
    color: "lightblue"
    border.color: "black"
    x: (Screen.width - 140 - this.width)/2
    y: (Screen.height - 140 - this.height)/2

    TextField    {
        placeholderText: "Your Name Here"
        anchors.centerIn: parent
        onAccepted: {
            componentLoader.source = "WelcomeScreen.qml"
            intoGameTimer.running = true
        }
    }

    CButton {
        text: "OK"
        width: 60
        height: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        color: "white"
        enterColor: "cyan"
        exitColor: "white"
        onEntered: textColor = "white"
        onExited: textColor = "black"
        onClicked: {
            componentLoader.source = "WelcomeScreen.qml"
            intoGameTimer.running = true
        }
    }
}
