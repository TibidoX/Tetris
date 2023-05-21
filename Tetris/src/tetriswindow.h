#ifndef TETRISWINDOW_H
#define TETRISWINDOW_H

#include <QObject>
#include <QWidget>
#include <QPushButton>
#include <QLCDNumber>
#include <QLabel>

class TetrisWindow: public QWidget
{
    Q_OBJECT
private:
    QLabel *createLabel(const QString &text);

    TetrisBoard *board;
    QLabel *nextPieceLabel;
    QLCDNumber *scoreLcd;
    QLCDNumber *levelLcd;
    QLCDNumber *linesLcd;
    QPushButton *startButton;
    QPushButton *quitButton;
    QPushButton *pauseButton;
public:
    TetrisWindow(QWidget *parent = nullptr);
};

#endif // TETRISWINDOW_H
