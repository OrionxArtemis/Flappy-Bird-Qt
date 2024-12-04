import QtQuick

Item {
    id: root

    property string path: ""
    property real imgWidth: 0
    property int imgNumber: 1
    property int duration: 250
    property bool isRunning: theLoader.isAnimationRunning

    ListModel {
        id: backModel

        Component.onCompleted: {
            for (var i = 0; i < root.imgNumber; i++) {
                backModel.append({ source: root.path })
            }
        }
    }

    Row {
        id: backRow

        spacing: 0

        Repeater {
            model: backModel
            delegate: Image {
                id: backImage

                source: model.source
                height: root.height
                width: window.calWidthFollowHeight(backImage)
                Component.onCompleted: {
                    root.imgWidth = backImage.width
                }
            }
        }
    }

    SequentialAnimation on x {
        loops: Animation.Infinite
        running: root.isRunning

        PropertyAnimation {
            from: 0
            to: -backRow.width
            duration: root.duration
            easing.type: Easing.Linear
       }
    }

    onXChanged: {
        if (-root.x >= root.imgWidth) {
            backModel.append({ source: root.path })
            if (backModel.count > root.imgNumber) {
                backModel.remove(0)
                root.x += root.imgWidth
            }
        }
    }
}
