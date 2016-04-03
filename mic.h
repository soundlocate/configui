#ifndef MIC_H
#define MIC_H

#include <QList>
#include <QMetaType>

struct Mic {
    qreal x = 0, y = 0, z = 0;

    bool operator==(const Mic & other) {
        return other.x == x && other.y == y && other.z == z;
    }
};

Q_DECLARE_METATYPE(Mic)

#endif // MIC_H
