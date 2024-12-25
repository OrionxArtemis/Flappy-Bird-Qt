#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QFontDatabase>
#include <backend.h>
#include <FontManager.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    FontManager::addFonts();
    qmlRegisterSingletonInstance<Backend>("com.flappyBird.backend", 1, 0, "Backend", Backend::initialize());
    app.setWindowIcon(QIcon(":/FlappyBird/images/Flappy_Bird_icon.png"));
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/FlappyBird/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
