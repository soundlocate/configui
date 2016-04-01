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
                id: textMaxClusterSize
                text: qsTr("maximum size of a cluster")
            }

            TextField {
                id: textFieldMaxClusterSize
                text: qsTr("0.5")
                placeholderText: qsTr("maximum size")
                validator: DoubleValidator {
                    bottom: 0
                    top: 100
                }
            }

            Label {
                id: textMaxKeep
                text: qsTr("maximum number of old points to keep")
            }

            TextField {
                id: textFieldMaxKeep
                text: qsTr("10")
                placeholderText: qsTr("maximum keep points")
                validator: IntValidator {
                    bottom: 0
                    top: 10000000
                }
            }

            Label {
                id: textMeanWindow
                text: qsTr("size of moving average window")
            }

            TextField {
                id: textFieldMeanWindow
                text: qsTr("3")
                placeholderText: qsTr("size of window")
                validator: IntValidator {
                    bottom: 0
                    top: 10000000
                }
            }

            Label {
                id: textKeepTime
                text: qsTr("time to keep old points")
            }

            TextField {
                id: textFieldKeepTime
                text: qsTr("0.5")
                placeholderText: qsTr("time")
                validator: DoubleValidator {
                    bottom: 0
                    top: 10000000
                }
            }
        }
    }
}
