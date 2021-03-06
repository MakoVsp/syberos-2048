#-------------------------------------------------
#
# Project generated by QtCreator for SyberOS.
#
#-------------------------------------------------

QML_IMPORT_PATH = $$[QT_INSTALL_QML]

RESOURCES += res.qrc

CONFIG += link_pkgconfig

PKGCONFIG += syberos-application syberos-application-cache

# This is needed for using syberos-application and syberos-qt module
INCLUDEPATH += $$[QT_INSTALL_HEADERS]/../syberos_application \
			   $$[QT_INSTALL_HEADERS]/../framework

QT += gui qml quick gui-private

TARGET = syberos2048

#Please Do not modify these macros, otherwise your app will not installed correctly and will not run at all.
APP_DIR = /data/apps
APP_DATA = /data/data
INS_DIR = $$APP_DIR/com.syberos.syberos2048
DATA_DIR = $$APP_DATA/com.syberos.syberos2048

DEFINES += SOP_ID=\\\"com.syberos.syberos2048\\\"
DEFINES += APP_DIR_ENVVAR=\\\"APPDIR_REGULAR\\\"
# Currently home screen sets the environment variable, so when run from
# elsewhere, use this work-around instead.
DEFINES += APP_DIR=\\\"$$APP_DIR\\\"

# The .cpp file which was generated for your project.
SOURCES += src/main.cpp \
           src/syberos2048_Workspace.cpp \
    src/settings.cpp
#    qml/2048.js

HEADERS += src/syberos2048_Workspace.h \
    src/settings.h

OBJECTS_DIR += ./tmp

# Installation path
target.path = $$INS_DIR/bin

res.files = res
res.path = $$INS_DIR/

meta.files = META-INF
meta.path = $$INS_DIR/

syber.files = sopconfig.xml
syber.path = $$INS_DIR/

ttf.files = fonts/DroidSansFallback.ttf
ttf.path = $$INS_DIR/

INSTALLS += target res meta syber ttf

QML_FILES = qml/*.qml

OTHER_FILES += $$QML_FILES *.qm
               


