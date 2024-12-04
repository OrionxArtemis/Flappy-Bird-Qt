import QtQuick

Item {
    id: root

    property string path: ""
    property real imgWidth: 0
    property int imgNumber: 1
    property int duration: 250

    ListModel {
        id: backModel

        Component.onCompleted: {
            if (root.imgNumber === 2) {
                append({ source: root.path })
                append({ source: root.path })
            } else if (root.imgNumber === 6) {
                append({ source: root.path })
                append({ source: root.path })
                append({ source: root.path })
                append({ source: root.path })
                append({ source: root.path })
                append({ source: root.path })
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
                width: backImage.sourceSize.width * backImage.height / backImage.sourceSize.height
                Component.onCompleted: {
                    root.imgWidth = backImage.width
                }
            }
        }
    }
    SequentialAnimation on x {
        loops: Animation.Infinite
        running: true

        PropertyAnimation {
            from: 0
            to: -backRow.width
            duration: root.duration
            easing.type: Easing.Linear
       }
    }
    onXChanged: {
        if ((-root.x / root.imgWidth) >= 1) {
            backModel.append({ source: root.path })
            if (backModel.count > root.imgNumber) {
                backModel.remove(0)
                root.x += root.imgWidth
            }
        }
    }
}
