#include <QtGui/QGuiApplication>
#include <QQmlContext>
#include <QDebug>
#include <qpa/qplatformnativeinterface.h>

#include "syberos2048_Workspace.h"
#include "settings.h"

syberos2048_Workspace::syberos2048_Workspace()
    : CWorkspace()
{
    m_view = SYBEROS::SyberosGuiCache::qQuickView();
    QObject::connect(m_view->engine(), SIGNAL(quit()), qApp, SLOT(quit()));
    Settings settings(0, "zhangpeng", "syberos-2048");
    m_view->engine()->rootContext()->setContextProperty("settings", &settings);
    m_view->setSource(QUrl("qrc:/qml/main.qml"));
    m_view->setTitle("2048");
    m_view->setFlags(m_view->flags() | Qt::FramelessWindowHint);

    QPlatformNativeInterface *native = QGuiApplication::platformNativeInterface();
    m_view->create();
    native->setWindowProperty(m_view->handle(), "STATUSBAR_VISIBLE", "true");
    native->setWindowProperty(m_view->handle(), "STATUSBAR_STYLE", "transBlack");
    m_view->engine()->rootContext()->setContextProperty("qquickView", m_view);

    m_view->showFullScreen();
}

void syberos2048_Workspace::onLaunchComplete(Option option, const QStringList& params)
{
    Q_UNUSED(params)

    switch (option) {
    case CWorkspace::HOME:
        qDebug()<< "---Syberos2048 Start by Home !!!";
        break;
    case CWorkspace::URL:
        break;
    case CWorkspace::EVENT:
        break;
    case CWorkspace::DOCUMENT:
        break;
    default:
        break;
    }
}


