import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    anchors.fill: parent

    TabView {
        id: configTabs
        tabPosition: 1
        anchors.fill: parent

        Tab {
            id: general
            title: "General"
            source: "General.qml"
        }

        Tab {
            id: soundSimulate
            title: "SoundSimulate"
            source: "SoundSimulate.qml"
        }

        Tab {
            id: soundFFT
            title: "SoundFFT"
            source: "SoundFFT.qml"
        }

        Tab {
            id: soundLocate
            title: "SoundLocate"
            source: "SoundLocate.qml"
        }

        Tab {
            id: soundReduce
            title: "SoundReduce"
            source: "SoundReduce.qml"
        }
    }
}
