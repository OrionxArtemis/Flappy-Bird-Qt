// backend.cpp
#include "backend.h"
#include <QDebug>

static Backend *instance = nullptr;

Backend* Backend::initialize(QObject *parent) {
    if (instance == nullptr) {
        instance = new Backend(parent);
        if (instance == nullptr) {
            qDebug("%s::%d::%s: Failed", __FILE__, __LINE__, __FUNCTION__);
        }
    }
    return instance;
}

Backend& Backend::getInstance() {
    if (instance == nullptr) {
        qDebug("%s::%d::%s: Failed", __FILE__, __LINE__, __FUNCTION__);
    }
    return *instance;
}

Backend::Backend(QObject *parent) : QObject(parent)
{
}

void Backend::addPoint() {
    QString point = "1";
    setPoint(point);
}

void Backend::setPoint(QString& point) {
    this->m_point++;
    emit pointChanged();
}

QString Backend::getPoint() const {
    QString ret = QString("%1").arg(this->m_point, 2, 10, QChar('0'));
    return ret;
}

void Backend::resetPoint() {
    this->m_point = 0;
    emit pointChanged();
}

void Backend::saveBestScore(const QVariant &value) {
    QSettings settings("FlappyBird", "BestScore");
    settings.setValue("bestScore", value);
}

QVariant Backend::getBestScore() {
    QSettings settings("FlappyBird", "BestScore");
    return settings.value("bestScore", "00");
}
