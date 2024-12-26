import QtQuick
import QtQuick.Controls

Rectangle{
    id: root

    readonly property int pipeSpace: 250

    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    Image {
        source: "file:///C:/Users/ACER/Desktop/46888871-624a3900-ce7f-11e8-808e-99fd90c8a3f4.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    CNumber{
        anchors{
            top: parent.top
            topMargin: 120
            horizontalCenter: parent.horizontalCenter
        }
        inputText: "01"
        z: 1
    }

    Rectangle {
        id: upPipe

        anchors{
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        width: 90
        height: parent.height - 300
        gradient: pipeColor
        border{
            color: "black"
            width: 3
        }

        Rectangle {
            anchors{
                top: parent.bottom
                topMargin: -3
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width + 20
            height: width / 3
            gradient: pipeColor
            border{
                color: "black"
                width: 3
            }
        }
    }
    Rectangle {
        id: downPipe

        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        width: upPipe.width
        height: parent.height - upPipe.height - root.pipeSpace
        gradient: pipeColor
        border{
            color: "black"
            width: 3
        }

        Rectangle {
            anchors{
                bottom: parent.top
                bottomMargin: -3
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width + 20
            height: width / 3
            border{
                color: "black"
                width: 3
            }
            gradient: pipeColor
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

    Bird {
        anchors{
            top: parent.top
            topMargin: 250
            left: parent.left
            leftMargin: 400
        }
    }
}

