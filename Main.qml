import QtQuick
import QtQuick.Controls
import QtMultimedia

ApplicationWindow {
    id: window

    function calWidthFollowHeight(img) {
        return img.sourceSize.width * img.height / img.sourceSize.height
    }

    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    visible: true
    title: qsTr("Flappy Bird")
    flags: Qt.Window | Qt.FramelessWindowHint

    Rectangle{
        id: theLoader

        property bool isAnimationRunning: true

        anchors.fill: parent

        BackAnimation {
            id: background

            anchors.top: parent.top
            height: window.height - theBase.height + 5
            path: "images/background.png"
            imgNumber: 2
            duration: 60000
        }

        Loader {
            id: screenLoader

            anchors.fill: parent
            focus: true
            asynchronous: true
            source: "HomeScreen.qml"
        }

        BackAnimation {
            id: theBase

            anchors.bottom: parent.bottom
            height: 100
            path: "images/base.png"
            imgNumber: 6
            duration: 15000
        }

        Loader {
            id: popupLoader

            anchors.fill: parent
            asynchronous: true
        }

        SoundManager {
            id: soundManager
        }
    }

    Row {
        id: windowButtons

        layoutDirection: Qt.RightToLeft
        anchors {
            right: parent.right
            top: parent.top
        }

        CButton {
            id: quitBtn

            enterColor: "red"
            exitColor: "transparent"
            onClicked: Qt.quit()

            Rectangle {
                id: cross1

                width: quitBtn.width * 0.7
                height: 4
                color: "white"
                rotation: 45
                anchors.centerIn: quitBtn
            }
            Rectangle {
                id: cross2

                width: quitBtn.width * 0.7
                height: 4
                color: "white"
                rotation: -45
                anchors.centerIn: quitBtn
            }
        }
        CButton {
            id: minimizeBtn

            enterColor: "black"
            exitColor: "transparent"
            onClicked: showMinimized()

            Rectangle {
                id: dash

                width: minimizeBtn.width * 0.5
                height: 4
                color: "white"
                anchors.centerIn: minimizeBtn
            }
        }
    }
}
