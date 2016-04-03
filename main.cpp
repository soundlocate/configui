#include "cpptoml.h"
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtWebEngine/QtWebEngine>
#include "config.h"
#include "micmodel.h"

int main(int argc, char *argv[])
{

    Config config("config.toml");

    QApplication app(argc, argv);

    QtWebEngine::initialize();
//QWebSettings::WebGLEnabled QWebSettings::AcceleratedCompositingEnabled
    QQmlApplicationEngine engine;

    MicModel micModel(&config);

    //  qmlRegisterType<Config>("de.sfn_kassel.locate", 1, 0, "Config");

    engine.rootContext()->setContextProperty("config", &config);
    engine.rootContext()->setContextProperty("micModel", &micModel);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
