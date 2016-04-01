import QtQuick 2.1
import QtQuick.Controls 1.0

Item {
    anchors.fill: parent

    TextArea {
        id: textArea1
        text: logData.get(0)["output"]
        textFormat: Text.RichText
        readOnly: true
        anchors.fill: parent
    }

    ListModel {
        id: logData
        ListElement {
            type: "o"
            time: "1999-293-123-123"
            program: "soundLocate"
            output: qsTr("<div style=\"color:#ffcc00;font-size:50pt;\"> hello, world! </div> lololo")
        }

        ListElement {
            type: "o"
            time: "1999-293-123-123"
            program: "soundLocate"
            output: "hello, world! reeeeeeeeeeeeeeeeeeaaaaaaaaaaaaaaaaaaaaaallllllllllllllllllllyyyyyyyyyyy loooooooooooooong outpuuuuuuuuuuuuuuuuuuuuuut"
        }
    }
}
