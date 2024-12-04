#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QFontDatabase>
#include <backend.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    // https://github.com/paulkr/Flappy-Bird/blob/master/lib/res/fonts/flappy-font.ttf
    QString fontPath1 = QGuiApplication::applicationDirPath() + "/fonts/flappy-font.ttf";
    // https://ggbot.itch.io/quinquefive-font
    QString fontPath2 = QGuiApplication::applicationDirPath() + "/fonts/QuinqueFive.ttf";

    int fontId = 0;
    fontId = QFontDatabase::addApplicationFont(fontPath1);
    if (fontId == -1) {
        qWarning("%s::%d::%s: Install font failed", __FILE__, __LINE__, __FUNCTION__);
    }
    fontId = QFontDatabase::addApplicationFont(fontPath2);
    if (fontId == -1) {
        qWarning("%s::%d::%s: Install font failed", __FILE__, __LINE__, __FUNCTION__);
    }

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
