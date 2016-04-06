#ifndef CONFIG_H
#define CONFIG_H

#include <QObject>
#include <QDebug>
#include <QString>
#include <QList>
#include <QUrl>
#include "mic.h"
#include "cpptoml.h"
#include <string>

class Config : public QObject
{
    Q_OBJECT
public:
    explicit Config(std::string filename, QObject *parent = 0);
    Q_PROPERTY(bool real MEMBER m_real NOTIFY configChanged)
    Q_PROPERTY(int samplerate MEMBER m_samplerate NOTIFY configChanged)
    Q_PROPERTY(bool log MEMBER m_log NOTIFY configChanged)
    Q_PROPERTY(QString logFilename MEMBER m_logfilename NOTIFY configChanged)
    Q_PROPERTY(QList<Mic> mics MEMBER m_mics NOTIFY configChanged)

    Q_PROPERTY(QString audioDeviceName MEMBER m_deviceName NOTIFY configChanged)

	Q_PROPERTY(QUrl soundFile MEMBER m_soundFile NOTIFY configChanged)

	Q_PROPERTY(int fftSize MEMBER m_fftSize NOTIFY configChanged)
    Q_PROPERTY(int fftFunction MEMBER m_fftFunction NOTIFY configChanged)
    Q_PROPERTY(int fftPerSec MEMBER m_fftPerSec NOTIFY configChanged)
	Q_PROPERTY(qreal fftThreshold MEMBER m_fftThres NOTIFY configChanged)

	Q_PROPERTY(bool algoPhase MEMBER m_algoPhase NOTIFY configChanged)
    Q_PROPERTY(bool algoPaV MEMBER m_algoPaV NOTIFY configChanged)
    Q_PROPERTY(bool algoPaA MEMBER m_algoPaA NOTIFY configChanged)
    Q_PROPERTY(qreal accuracy MEMBER m_accuracy NOTIFY configChanged)

	Q_PROPERTY(qreal maxClusterSize MEMBER m_maxClusterSize NOTIFY configChanged)
    Q_PROPERTY(int maxKeep MEMBER m_maxKeep NOTIFY configChanged)
    Q_PROPERTY(int meanWindow MEMBER m_meanWindow NOTIFY configChanged)
    Q_PROPERTY(qreal keepTime MEMBER m_keepTime NOTIFY configChanged)
	Q_PROPERTY(int disFunc MEMBER m_disFunc NOTIFY configChanged)


    void writeConfig();
    void readConfig();
signals:
    void configChanged();

public slots:
    void configHasChanged() {
		writeConfig();
    }

private:
	std::shared_ptr<cpptoml::table> table;

    // General
    bool m_real;
    int m_samplerate;
    bool m_log;
    QString m_logfilename;
    QList<Mic> m_mics;

    // soundInput
    QString m_deviceName;

    // soundSimulate
    QUrl m_soundFile;

    // soundFFT
    int m_fftSize;
    int m_fftFunction;
    int m_fftPerSec;
    qreal m_fftThres;

    // soundLocate
    bool m_algoPhase;
    bool m_algoPaV;
    bool m_algoPaA;
    qreal m_accuracy;

    // soundReduce
    qreal m_maxClusterSize;
    int m_maxKeep;
    int m_meanWindow;
    qreal m_keepTime;
	int m_disFunc;
};

#endif // CONFIG_H
