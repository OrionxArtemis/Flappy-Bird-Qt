import QtQuick


Rectangle {
    id: root

    property string enterColor: ""
    property string exitColor: ""
    property string text: ""
    property string textColor: "black"

    signal clicked()
    signal entered()
    signal exited()

    width: 40
    height: 40
    color: "transparent"

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: root.text
        color: root.textColor
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            root.color = root.enterColor
            root.entered()
        }
        onExited: {
            root.color = root.exitColor
            root.exited()
        }
        onClicked: root.clicked()
    }

    Behavior on color {
        ColorAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }
}
