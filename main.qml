import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Dialogs 1.2
import de.sfn_kassel.locate 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("soundLocate")
/*
    Config {
        id: config
    }
*/
    LogText {
        id: logText
    }

    TabView {
        id: tabView1
        anchors.bottomMargin: 30
        anchors.fill: parent
        tabPosition: 8

        Tab {
            id: config1
            title: "Config"
            source: "Config.qml"
        }

        Tab {
            id: status1
            title: "Status"
            source: "Status.qml"
        }

        Tab {
            id: output1
            title: "Output"
            source: "Output.qml"
        }

    }

    Text {
        id: statusText
        x: 5
        y: 450
        text: logText.sText
        textFormat: Text.RichText
        anchors.top: tabView1.bottom
        anchors.topMargin: 0
        font.pixelSize: 20
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
    }


    Button {
        id: buttonStop
        x: 467
        y: 450
        text: qsTr("Stop")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: tabView1.bottom
        anchors.topMargin: 0
        anchors.right: buttonStart.left
        anchors.rightMargin: 5

        onClicked: {
            logText.stop(false)
            buttonRestart.visible = false
            visibilityChanged(buttonRestart.visible)
            buttonStart.visible = true
            visibilityChanged(buttonStart.visible)
        }
    }

    Button {
        id: buttonStart
        x: 556
        y: 450
        text: qsTr("Start")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: tabView1.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        onClicked: {
            logText.start()
            visible = false
            visibilityChanged(visible)
            buttonRestart.visible = true
            visibilityChanged(buttonRestart.visible)
        }
    }

    Button {
        id: buttonRestart
        x: 556
        y: 450
        text: qsTr("Restart")
        visible: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: tabView1.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        onClicked: {
            logText.stop(true)
        }
    }
}
