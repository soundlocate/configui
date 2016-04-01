import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1

Item {
    anchors.fill: parent

    TabView {
        id: tabView1
        anchors.fill: parent

        Tab {
            id: log1
            title: "Log"
            source: "Log.qml"
        }

/*        Tab {
            id: connections1
            title: "Connections"
            source: "Connections.qml"
        }
*/   }
}
