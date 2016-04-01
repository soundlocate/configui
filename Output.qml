import QtQuick 2.1
import QtWebEngine 1.1

Item {
    anchors.fill: parent

    WebEngineView {
        id: webView
        anchors.fill: parent
        //url: "https://get.webgl.org/"
        url: "index.html?s=10.0.23.192:8080"
    }
}
