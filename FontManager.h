#ifndef FONTMANAGER_H
#define FONTMANAGER_H

#include <QFontDatabase>
#include <QGuiApplication>
#include <QDebug>
#include <QStringList>

class FontManager
{
public:
    FontManager() {}
    static void addFonts(const QStringList &fontPaths = defaultFontPaths());

private:
    static QStringList defaultFontPaths();
};

#endif // FONTMANAGER_H
