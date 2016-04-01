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
                    checked: true
                }

                CheckBox {
                    id: checkBoxPandV
                    text: qsTr("PhaseAndVelocity")
                }

                CheckBox {
                    id: checkBoxPandA
                    text: qsTr("PhaseAndAmplitude")
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
                    text: qsTr("0.01")
                    placeholderText: qsTr("accuracy")
                    validator: DoubleValidator {
                        bottom: 0
                        top: 100
                    }
                }
            }
        }
    }
}
