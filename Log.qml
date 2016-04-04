import QtQuick 2.1
import QtQuick.Controls 1.0

Item {
    anchors.fill: parent

    TextArea {
        id: logTextArea
        text: logText.logText
        textFormat: Text.RichText
        readOnly: true
        anchors.fill: parent

        onTextChanged: {
            cursorPosition = length
        }
    }
}
