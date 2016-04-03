import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1

Item {
    anchors.fill: parent

    Column {
        id: column1
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        GroupBox {
            id: groupBox1
            flat: true
            title: "Algorithms"
            Layout.fillWidth: true

            Column {
                id: column2
                Layout.fillWidth: true

                CheckBox {
                    id: checkBoxPOnly
                    text: qsTr("PhaseOnly")
                    checked: config.algoPhase

                    Component.onCompleted: {
                        config.algoPhase = Qt.binding(function() {return checked})
                    }
                }

                CheckBox {
                    id: checkBoxPandV
                    text: qsTr("PhaseAndVelocity")
                    checked: config.algoPaV

                    Component.onCompleted: {
                        config.algoPaV = Qt.binding(function() {return checked})
                    }
                }

                CheckBox {
                    id: checkBoxPandA
                    text: qsTr("PhaseAndAmplitude")
                    checked: config.algoPaA

                    Component.onCompleted: {
                        config.algoPaA = Qt.binding(function() {return checked})
                    }

                }
            }
        }

        GroupBox {
            id: groupBox2
            flat: true
            Layout.fillWidth: true

            Row {
                id: row1
                spacing: 5
                anchors.fill: parent
                Label {
                    id: textAccuracy
                    text: qsTr("accuracy of numeric solution")
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextField {
                    id: textFieldAccuracy
                    text: config.accuracy
                    placeholderText: qsTr("accuracy")
                    validator: DoubleValidator {
                        bottom: 0
                        top: 100
                    }

                    Component.onCompleted: {
                        config.accuracy = Qt.binding(function() {return Number(parseFloat(text)) > 0 ? Number(parseFloat(text)) : 0})
                    }
                }
            }
        }
    }
}
