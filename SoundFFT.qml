import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Item {
    anchors.fill: parent

    Column {
        id: column1
        anchors.fill: parent


        Grid {
            id: grid1
            columnSpacing: 10
            rows: 10
            columns: 2
            anchors.fill: parent
            verticalItemAlignment: Grid.AlignVCenter

            Label {
                id: textFFTSize
                text: qsTr("size of FFT")
                transformOrigin: Item.Center
                font.pixelSize: 12
            }

            TextField {
                id: textFieldSamplerate
                text: config.fftSize
                placeholderText: qsTr("fftsize")
                validator: IntValidator{bottom: 1; top: 19200000;}

                Component.onCompleted: {
                    config.fftSize = Qt.binding(function() {return Number(parseFloat(text)) > 1 ? Number(parseFloat(text)) : Number(1)})
                }
            }

            Label {
                id: textFFTSize1
                text: qsTr("windowing function")
                font.pixelSize: 12
            }

            ComboBox {
                id: comboBox1
                width: 200
                currentIndex: config.fftFunction
                model: [ "Hamming window", "Hanning window", "Rectangle window" ]

                Component.onCompleted: {
                    config.fftFunction = Qt.binding(function() { return currentIndex })
                }
            }

            Label {
                id: textFFTperSec
                text: qsTr("FFT per second")
                font.pixelSize: 12
            }

            TextField {
                id: textFieldSamplerate1
                text: config.fftPerSec
                placeholderText: qsTr("fftPerSec")
                validator: IntValidator {
                    bottom: 1
                    top: 100
                }

                Component.onCompleted: {
                    config.fftPerSec = Qt.binding(function() {return Number(parseInt(text)) > 1 ? Number(parseInt(text)) : Number(1)})
                }
            }
        }
    }
}
