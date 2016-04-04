#include "controller.h"

Controller::Controller(QQmlApplicationEngine * e, QObject *parent) : QObject(parent), engine(e) {
    textArea = e->findChild<QObject*>("logText");
    textArea->setProperty("logText", "Hello, world!");
}

void Controller::start() {
    QProcess * p = new QProcess();
    QObject::connect(p, &QProcess::started, this, &Controller::started);
//   QObject::connect(p, &QProcess::finished, this, &Controller::stopped);
    QObject::connect(p, &QProcess::readyRead, this, &Controller::readReady);

    process = p;

    QStringList args;
    args << "-jar" << "configServer.jar";

    p->start(QString("java"), args);
}

void Controller::stop() {
    if(process != nullptr)
        process->kill();
}
void Controller::readReady() {
    while(process->canReadLine()) {
     //   process->read
    }
}
