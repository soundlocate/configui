#ifndef MICMODEL_H
#define MICMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QStringList>
#include <QDir>
#include <QUrl>
#include <QDateTime>
#include <QDebug>
#include "config.h"

class MicModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum MicRoles {
        xRole = Qt::UserRole + 1,
        yRole,
        zRole
    };

    MicModel(Config * config, QObject *parent = 0);

    void addMic(const Mic &mic);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    Q_INVOKABLE QString ownData(const int index, QString role) const;
    Q_INVOKABLE bool setOwnData(const int index, const QString &value, QString role);
    Qt::ItemFlags flags(const QModelIndex &index) const;
    Q_INVOKABLE bool append(const QModelIndex &parent = QModelIndex());
    Q_INVOKABLE bool remove(const QModelIndex &parent = QModelIndex());

signals:
    void micsChanged();
public slots:

protected:
        QHash<int, QByteArray> roleNames() const;

private:
        Config * c;
        QList<Mic> m_mics;

};

#endif // MICMODEL_H
