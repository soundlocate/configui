#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QProcess>

class Controller : public QObject
{
    Q_OBJECT
public:
    explicit Controller(QQmlApplicationEngine * e, QObject *parent = 0);

    void start();
    void stop();
    void configHasChanged();
signals:

public slots:
    void started() {};
    void stopped() {};
    void readReady();
private:
    QQmlApplicationEngine * engine;
    QProcess * process;
    QObject * textArea;
};

#endif // CONTROLLER_H
