TEMPLATE = app

QT += qml quick widgets webengine

CONFIG += gnu++14

SOURCES += main.cpp \
    config.cpp \
    micmodel.cpp \
    mic.cpp \
    controller.cpp \
    logtext.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES +=

HEADERS += \
    config.h \
    micmodel.h \
    mic.h \
    cpptoml.h \
    controller.h \
    logtext.h

CONFIG(release, debug|release):DEFINES += QT_NO_DEBUG_OUTPUT
