#ifndef LOGTEXT_H
#define LOGTEXT_H

#include <QObject>
#include <QProcess>
#include <QDebug>
#include <QThread>
#include <QEventLoop>

class LogText : public QObject
{
    Q_OBJECT
public:
    explicit LogText(QObject *parent = 0);
    Q_PROPERTY(QString logText MEMBER m_logText NOTIFY logTextChanged)
    Q_PROPERTY(QString sText MEMBER m_sText NOTIFY sTextChanged)
    Q_PROPERTY(int wPort MEMBER m_wport NOTIFY wPortChanged)

    Q_INVOKABLE void start();
    Q_INVOKABLE void stop(bool restart);
    Q_INVOKABLE void configHasChanged();
signals:
    void logTextChanged();
    void sTextChanged();
    void wPortChanged();
public slots:
    void started() {
        running = true;
        QString status = "<span style=\"color: green;font-weight: bold;\">running</span>";
        m_sText = status;
        emit sTextChanged();
    }
    void finished(int,QProcess::ExitStatus) {
        m_logText += "</table>";
        m_sText = "<span style=\"color: red;font-weight: bold;\">off</span>";
        running = false;

        if(restart) {
            start();
            restart = false;
        }

        emit sTextChanged();
        emit logTextChanged();
    }

    void readyRead() {
        //qDebug() << p.readAll();
       // qDebug() << "readyRead";
        auto text = p.readAll();
        auto t2 = text;
        if(t2.contains("binding websocket to")) {
            auto segments = t2.split(' ');
            for(int i = 0; i < segments.size() - 2; i++) {
                if(segments[i] == "websocket" && segments[i + 1] == "to") {
                    m_wport = segments[i + 2].toInt();
                    emit wPortChanged();
                }
            }
        }

        m_logText += text;
        emit logTextChanged();
    }

private:
    QString m_sText = "<span style=\"color: red;font-weight: bold;\">off</span>";
    QString m_logText = "";
    QProcess p;
    int m_wport;
    bool running = false;
    bool restart = false;
};

#endif // LOGTEXT_H
