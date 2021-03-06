import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1

Item {
    anchors.fill: parent

    Column {
        id: column1
        width: 200
        height: 400

        Grid {
            id: grid1
            rows: 10
            columns: 2
            anchors.fill: parent
            spacing: 5
            verticalItemAlignment: Grid.AlignVCenter

            Label {
                id: textFFTSize1
                text: qsTr("windowing function")
                font.pixelSize: 12
            }

            ComboBox {
                id: comboBox1
                width: 200
                currentIndex: config.disFunc
                model: [ "Distance", "Direction" ]

                Component.onCompleted: {
                    config.disFunc = Qt.binding(function() { return currentIndex })
                }
            }

            Label {
                id: textMaxClusterSize
                text: qsTr("maximum size of a cluster")
            }

            TextField {
                id: textFieldMaxClusterSize
                text: config.maxClusterSize
                placeholderText: qsTr("maximum size")
                validator: DoubleValidator {
                    bottom: 0
                    top: 100
                }

                Component.onCompleted: {
                    config.maxClusterSize = Qt.binding(function() {return Number(parseFloat(text)) > 0 ? Number(parseFloat(text)) : 0})
                }
            }

            Label {
                id: textMaxKeep
                text: qsTr("maximum number of old points to keep")
            }

            TextField {
                id: textFieldMaxKeep
                text: config.maxKeep
                placeholderText: qsTr("maximum keep points")
                validator: IntValidator {
                    bottom: 0
                    top: 10000000
                }

                Component.onCompleted: {
                    config.maxKeep = Qt.binding(function() {return Number(parseInt(text)) >= 0 ? Number(parseInt(text)) : 0})
                }
            }

            Label {
                id: textMeanWindow
                text: qsTr("size of moving average window")
            }

            TextField {
                id: textFieldMeanWindow
                text: config.meanWindow
                placeholderText: qsTr("size of window")
                validator: IntValidator {
                    bottom: 0
                    top: 10000000
                }

                Component.onCompleted: {
                    config.meanWindow = Qt.binding(function() {return Number(parseInt(text)) >= 0 ? Number(parseInt(text)) : 0})
                }
            }

            Label {
                id: textKeepTime
                text: qsTr("time to keep old points")
            }

            TextField {
                id: textFieldKeepTime
                text: config.keepTime
                placeholderText: qsTr("time")
                validator: DoubleValidator {
                    bottom: 0
                    top: 10000000
                }

                Component.onCompleted: {
                    config.keepTime = Qt.binding(function() {return Number(parseFloat(text)) >= 0 ? Number(parseFloat(text)) : 0})
                }
            }
        }
    }
}
