#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtWebEngine/QtWebEngine>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QtWebEngine::initialize();
//QWebSettings::WebGLEnabled QWebSettings::AcceleratedCompositingEnabled
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
