#include "micmodel.h"

MicModel::MicModel(Config * c, QObject *parent)
    : QAbstractListModel(parent), c(c)
{
    m_mics = c->property("mics").value<QList<Mic>>();
}

void MicModel::addMic(const Mic &mic)
{
    m_mics << mic;
}

int MicModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_mics.count();
}

bool MicModel::setOwnData(const int index, const QString &value, QString role) {
    if(role == "x") {
        m_mics[index].x = value.toDouble();
    } else if(role == "y") {
        m_mics[index].y = value.toDouble();
    } else if(role == "z") {
        m_mics[index].z = value.toDouble();
    } else {
        return false;
    }

    for(int i = 0; i < m_mics.size(); i++) {

    }

    QVariant q;
    q.setValue(m_mics);

    c->setProperty("mics", q);

   // emit dataChanged(QModelIndex, index);
    return true;
}

bool MicModel::append(const QModelIndex &parent) {
    Mic m;
    m.x = 0;
    m.y = 0;
    m.z = 0;

    beginInsertRows(parent, m_mics.size(), m_mics.size());
    m_mics.append(m);
    endInsertRows();

    QVariant q;
    q.setValue(m_mics);

    c->setProperty("mics", q);

    return true;
}

bool MicModel::remove(const QModelIndex &parent) {
    if(m_mics.size() <= 0)
        return false;

    beginRemoveRows(parent, m_mics.size() - 1, m_mics.size());
    m_mics.removeLast();
    endRemoveRows();

    QVariant q;
    q.setValue(m_mics);

    c->setProperty("mics", q);

    return true;
}


Qt::ItemFlags MicModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return 0;

    return Qt::ItemIsEditable | QAbstractItemModel::flags(index);
}

QVariant MicModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_mics.count())
        return QVariant();

    const Mic &mic = m_mics[index.row()];
    if (role == xRole) {
        return QVariant(mic.x);
    } else if (role == yRole) {
        return QVariant(mic.y);
    } else if (role == zRole) {
        return QVariant(mic.z);
     }

    return QVariant();
}

QString MicModel::ownData(const int index, QString role) const {
    if (index < 0 || index >= m_mics.count())
         return QString();


    const Mic &mic = m_mics[index];
    if (role == "x") {
        return QString::number(mic.x);
    } else if (role == "y") {
        return QString::number(mic.y);
    } else if (role == "z") {
        return QString::number(mic.z);
    }

    return QString();
}

QHash<int, QByteArray> MicModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[xRole] = "x";
    roles[yRole] = "y";
    roles[zRole] = "z";
    return roles;
}

