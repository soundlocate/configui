import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1

Item {
    anchors.fill: parent

    Column {
        id: column1
        anchors.fill: parent

        GroupBox {
            id: groupBox1
            flat: true
            Layout.fillWidth: true

            Row {
                id: row1
                spacing: 5
                anchors.fill: parent
                Label {
                    id: textAudioDevice
                    text: qsTr("audio device name")
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextField {
                    id: textAudioDeviceName
                    text: "pulse"
                    placeholderText: qsTr("device name")
                }
            }
        }
    }
}
