import QtQuick 2.5
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

Item {
    anchors.fill: parent

    FileDialog {
        id: openAudioFile
        title: qsTr("select a *.wav file to use")
        nameFilters: [ "Audio files (*.wav)" ]

        onAccepted: {
            config.soundFile = fileUrl
            var path = fileUrl.toString()
            path = path.replace(/^(file:\/{3})/,"/")
            var cleanPath = decodeURIComponent(path)
            textFieldAudioFileName.text = cleanPath
        }
    }

    Column {
        id: column1

        GroupBox {
            id: groupBox1
            flat: true
            Layout.fillWidth: true

            Row {
                id: row1
                spacing: 5
                anchors.fill: parent
                Label {
                    id: textAudioFileName
                    text: qsTr("audiofile name ")
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextField {
                    id: textFieldAudioFileName
                    width: 300
                    anchors.verticalCenter: parent.verticalCenter
                    readOnly: true
                    text: config.soundFile.toString()
                    placeholderText: qsTr("filename")
                }

                Button {
                    id: fileDialogButton
                    width: 33
                    text: qsTr("...")

                    onClicked: openAudioFile.open()
                }
            }
        }
    }
}
