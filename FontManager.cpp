#include "FontManager.h"

void FontManager::addFonts(const QStringList &fontPaths)
{
    for (const QString &fontPath : fontPaths) {
        int fontId = QFontDatabase::addApplicationFont(fontPath);
        if (fontId == -1) {
            qWarning("Failed to install font: %s", fontPath.toUtf8().constData());
        } else {
            qDebug() << "Successfully installed font:" << fontPath;
        }
    }
}

QStringList FontManager::defaultFontPaths()
{
    return {
        // https://github.com/paulkr/Flappy-Bird/blob/master/lib/res/fonts/flappy-font.ttf
        QGuiApplication::applicationDirPath() + "/fonts/flappy-font.ttf",
        // https://ggbot.itch.io/quinquefive-font
        QGuiApplication::applicationDirPath() + "/fonts/QuinqueFive.ttf"
    };
}
