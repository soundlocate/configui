import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Item {
    id: item1
    anchors.fill: parent

    Column {
        id: column1
        anchors.leftMargin: 5
        anchors.topMargin: 5
        anchors.fill: parent

        GroupBox {
            id: groupBox1
            flat: true
            Layout.fillWidth: true

            CheckBox {
                id: checkBoxReal
                text: qsTr("  real")
                checked: config.real

                Component.onCompleted: {
                    config.real = Qt.binding(function() { return checked})
                }

                onCheckedChanged: {
                    if(checked) {
                        configTabs.insertTab(1, "SoundInput", Qt.createComponent("SoundInput.qml"))
                    } else {
                        configTabs.removeTab(1)
                    }
                }
            }

            Row {
                id: row1
                x: 0
                anchors.top: checkBoxReal.bottom
                anchors.topMargin: 0
                spacing: 66
                CheckBox {
                    id: checkBoxCreateLogFile
                    height: 29
                    text: qsTr("  create logfile")
                    anchors.verticalCenter: parent.verticalCenter
                    onCheckedChanged: textFieldLogName.visible = checked
                    checked: config.log

                    Component.onCompleted: {
                        config.log = Qt.binding(function() { return checked})
                    }
                }

                TextField {
                    id: textFieldLogName
                    visible: false
                    text: config.logFilename
                    placeholderText: qsTr("logfilename")

                    Component.onCompleted: {
                        config.logFilename = Qt.binding(function() {return text})
                    }
                }
            }

            Row {
                id: row2
                x: 0
                anchors.top: row1.bottom
                anchors.topMargin: 0
                spacing: 100

                Label {
                    id: textSamplerate
                    text: qsTr("samplerate")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 12
                }

                TextField {
                    id: textFieldSamplerate
                    text: config.samplerate
                    placeholderText: qsTr("samplerate")
                    validator: IntValidator{bottom: 0; top: 19200000;}

                    Component.onCompleted: {
                        config.samplerate = Qt.binding(function() {return Number(parseFloat(text)) > 1 ? Number(parseFloat(text)) : Number(1)})
                    }
                }
            }
        }

        GroupBox {
            id: groupBox4
            height: 200
            anchors.top: groupBox1.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            flat: true

            Label {
                id: textMikrofone
                x: -8
                text: qsTr("Mikrofone:")
                anchors.top: parent.top
                anchors.topMargin: 0
                font.pixelSize: 12
            }

            TableView {
                id: micTable
                anchors.top: textMikrofone.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.topMargin: 0

                itemDelegate: TextInput {
                    text: styleData.value
                    validator: DoubleValidator{bottom: -100000000; top: 1000000000;}

                    onEditingFinished: {
                        var a = styleData.row
                        var b = styleData.role
                        micModel.setOwnData(a, text, b)
                        text = micModel.ownData(a, b)
                    }
                }

                TableViewColumn {
                    role: "x"
                    title: "x"
                }
                TableViewColumn {
                    role: "y"
                    title: "y"
                }
                TableViewColumn {
                    role: "z"
                    title: "z"
                }
                model: micModel
            }


            Row {
                id: row3
                x: -8
                width: 200
                height: 400
                anchors.top: micTable.bottom
                anchors.topMargin: 0

                Button {
                    id: buttonAddMic
                    text: qsTr("add")
                    onClicked: micModel.append()
                }

                Button {
                    id: buttonRemoveMic
                    text: qsTr("remove")
                    onClicked: {
                        forceActiveFocus()
                        micModel.remove()
                    }
                }
            }

        }
    }

/*
    ListModel {
        id: micModel
        ListElement {
            x: 0.0
            y: 0.0
            z: 0.0
        }
        ListElement {
            x: 0.0
            y: 1.0
            z: 0.0
        }
        ListElement {
            x: 1.0
            y: 0.0
            z: 0.0
        }
        ListElement {
            x: 1.0
            y: 1.0
            z: 0.0
        }
        ListElement {
            x: 0.0
            y: 0.0
            z: 1.0
        }
        ListElement {
            x: 1.0
            y: 0.0
            z: 1.0
        }
        ListElement {
            x: 0.0
            y: 1.0
            z: 1.0
        }
        ListElement {
            x: 1.0
            y: 1.0
            z: 1.0
        }

        onDataChanged: {

        }
    }
    */
}
