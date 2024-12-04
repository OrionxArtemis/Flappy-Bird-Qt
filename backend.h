// backend.h
#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include <QSettings>

class Backend : public QObject
{
    Q_OBJECT

public:
    static Backend& getInstance();
    static Backend* initialize(QObject *parent = nullptr);

    Q_PROPERTY(QString getPoint READ getPoint WRITE setPoint NOTIFY pointChanged)
    void setPoint(QString& point);
    QString getPoint() const;
    Q_INVOKABLE void addPoint();
    Q_INVOKABLE void resetPoint();
    Q_INVOKABLE void saveBestScore(const QVariant &value);
    Q_INVOKABLE QVariant getBestScore();

protected:
    explicit Backend(QObject *parent = nullptr);

signals:
    void pointChanged();

private:
    uint8_t m_point = 0;
};

#endif // BACKEND_H
