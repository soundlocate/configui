#include "logtext.h"

LogText::LogText(QObject *parent) : QObject(parent)
{

}

void LogText::start() {
    QStringList args;
    args << "-jar" << "configServer.jar";

    p.kill();
    p.setProcessChannelMode(QProcess::MergedChannels);
    p.setProgram(QString("java"));
    p.setArguments(args);
    QObject::connect(&p, SIGNAL(started()), this, SLOT(started()));
    QObject::connect(&p, SIGNAL(finished(int,QProcess::ExitStatus)), this, SLOT(finished(int,QProcess::ExitStatus)));
    QObject::connect(&p, SIGNAL(readyRead()), this, SLOT(readyRead()));

    p.start(QIODevice::ReadOnly);
}

void LogText::stop(bool restart) {
    this->restart = restart;
    p.terminate();
    m_logText += "</table>";
    emit logTextChanged();
}

void LogText::configHasChanged() {
    if(running)
        m_sText = "<span style=\"color: orange;font-weight: bold;\">running, but config change not used</span>";

    emit sTextChanged();
}
