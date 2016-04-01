import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1


Item {
    id: item1
    Layout.minimumHeight: 200

    Canvas {
        id: canvas;
        anchors.fill: parent;
        contextType: "2d";
        renderStrategy: Canvas.Threaded;
        renderTarget: Canvas.Image;
        antialiasing: true;
        smooth: true;

        onPaint: {
            if (context) {
                console.log(rFFT.y);
                context.clearRect (0, 0, width, height);
                context.beginPath ();
                context.moveTo(rIn.x + rIn.width / 2, rIn.y + rIn.height);
                context.lineTo(rFFT.x + rFFT.width / 2, rFFT.y);
                context.stroke();
            }
        }

    }

    /*
    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            // inputToFFT
            //ctx.fillStyle="#FF0000";
            ctx.clearRect(0,0,canvas.width,canvas.height);
            ctx.moveTo(rIn.x + rIn.width / 2, rIn.y + rIn.height)
            ctx.lineTo(rFFT.x + rFFT.width / 2, rFFT.y)
            ctx.stroke();
            //
        }
    }

    Rectangle {
        id: rSim
        width: 100
        height: 20
        color: "transparent"
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 30
        border.color: "black"
        radius: 5
        antialiasing: true

        Label {
            text: "soundSimulate"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }*/

    Rectangle {
        id: rFFT
        width: 100
        height: 20
        color: "#00000000"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 30
        border.color: "#000000"
        radius: 5
        antialiasing: true

        Label {
            text: "soundFFT"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: rLoc
        width: 100
        height: 20
        color: "#00000000"
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        border.color: "#000000"
        radius: 5
        antialiasing: true

        Label {
            text: "soundLocate"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: rIn
        width: 100
        height: 20
        color: "#00000000"
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 30
        border.color: "#000000"
        radius: 5
        antialiasing: true

        Label {
            text: "soundInput"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
