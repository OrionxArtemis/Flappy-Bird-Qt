import QtQuick

Item {
    id: root

    property bool isGameStart: false

    anchors.fill: parent

    Image {
        id: gameTitle

        anchors.horizontalCenter: parent.horizontalCenter
        source: "Image/title.png"
        height: 200
        width: window.calWidthFollowHeight(gameTitle)

        NumberAnimation on y {
            running: true
            from: 0
            to: 200
            duration: 800
            easing.type: Easing.OutQuad
        }

        NumberAnimation on y {
            running: root.isGameStart
            to: -200
            duration: 800
            easing.type: Easing.OutQuad
        }
    }

    Image {
        id: startButton

        anchors.horizontalCenter: parent.horizontalCenter
        source: "Image/startButton.png"
        height: 100
        width: window.calWidthFollowHeight(startButton)

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.isGameStart = true
            }
        }

        NumberAnimation on y {
            running: true
            from: window.height - theBase.height
            to: 500
            duration: 800
            easing.type: Easing.OutQuad
        }

        NumberAnimation on y {
            running: root.isGameStart
            to: window.height - theBase.height
            duration: 800
            easing.type: Easing.OutQuad
            onFinished: {
                screenLoader.source = "GameScreen.qml"
                popupLoader.source = "ReadyScreen.qml"
            }
        }
    }
}
