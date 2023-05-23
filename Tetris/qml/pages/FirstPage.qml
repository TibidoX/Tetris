/*****************************************************************************
**                                                                          **
** Created by Antonio Mancini                                               **
** Contact: <ziobilly94@gmail.com>                                          **
** This is a version of classic Tetris game for SailfishOS developed        **
** entirely by me, no copyright infringement intended.                      **
**                                                                          **
*****************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
//import harbour.sailtris.FileIO 1.0
import ".."

Page {

//    FileIO {
//        id: fileIO
//    }

    Functions {
        id: functions
    }

    id: page
    property int scoreValue
    //property int speedValue
    property real difficulty: 1
    property int level
    property int activeBlock
    property int futureBlock: -1
    property bool savedGame: false
    property string difficultyText: difficulty === 0.5 ? qsTr("Very Hard") : difficulty === 0.75 ? qsTr("Hard") :difficulty === 1 ? qsTr("Normal") :difficulty === 1.5 ? qsTr("Easy") : qsTr("Very Easy")
    property int combo: 1
    property int gravityBreak: 1
    property bool pauseVal

    // 0 = l_normal; 1 = l_reverse;
    // 2 = s_normal; 3 = s_reverse;
    // 4 = t_normal; 5 = square;
    // 6 = line

    property variant activeColor
    property variant futureColor

    property real centerX
    property real centerY

    //zamenit'
    Timer {
        id: gameOverTimer
        property int i: 15
        property int j: 11
        property bool clear: true
        interval: 1 //20
        repeat: true
        onTriggered : {
            for (var i = 0; i < 204; i++) {
                if (!(i < 12 || i > 191 || i % 12 === 0 || i % 12 === 11)) {
                    repeater.itemAt(i).opacity = 0.1
                }
            }
        }
    }


    Timer {
        id: downTimer
        interval: difficulty*(1338*Math.pow(Math.E,-0.26*level)+150)
        repeat: true
        running: false
        onTriggered: {
            functions.flow()
            //scoreValue += 1
            //speedValue += 1
        }
    }

    SilicaFlickable {
        id: root
        anchors.fill: page
        contentHeight : height


            Button {
                text: qsTr("New Game")
                onClicked: functions.newGame()
                anchors{
                    bottom: futureGrid.bottom
                    left: parent.left
                }
            }

        Label {
            id: score
            text:  difficultyText + " \n" + qsTr("Score ") + scoreValue + "\n"
            anchors {
                top: parent.top
                left: parent.left
                leftMargin: Theme.paddingLarge
            }
        }
        Label {
            id: next
            anchors {
                bottom: futureGrid.top
                horizontalCenter: futureGrid.horizontalCenter
            }
            text: qsTr("Next")
            font.pixelSize: Theme.fontSizeSmall
        }

        Grid {
            id: futureGrid
            anchors {
                top: parent.top
                right: parent.right
                topMargin: Theme.paddingLarge*2
                rightMargin: Theme.paddingLarge
            }
            columns: 4
            rows: 3
            Repeater {
                id: futureRepeater
                model: 12
                delegate: Dot {width: Theme.paddingLarge*5/3 ;color: Theme.secondaryColor; opacity: 0.1}
            }
        }

        Rectangle {
            id: rect
            width: grid.width
            height: grid.height
            anchors {
                bottom: parent.bottom
                bottomMargin: Theme.paddingMedium
            }
            border.color: "transparent"
            color: "transparent"
            opacity: 1
            // Dots grid
            Grid {
                id: grid
                columns: 12
                rows: 17
                Repeater {
                    id: repeater
                    model: 204
                    delegate: Dot {width: page.width/12 ;color: Theme.secondaryColor; opacity: 0.1}
                    onItemAdded: {
                        if (index < 12 || index > 191 || index % 12 === 0 || index % 12 === 11) {
                            itemAt(index).active = 3
                            itemAt(index).color = Theme.highlightColor
                            itemAt(index).opacity = 1
                        }
                    }
                }
            }
            MouseArea {
                id: mouseArea
                enabled: false
                anchors.fill: grid

                property real prevX
                property real prevY

                onPressed: {
                    prevX = mouseX
                    prevY = mouseY
                }
                onReleased: {
                    if ( Math.abs(prevY-mouseY) < Theme.paddingMedium &&
                         Math.abs(prevX-mouseX) < Theme.paddingMedium) { // Click
                        functions.rotate()
                        //console.log("Tap")
                    }
                    else
                        if ( Math.abs(prevY-mouseY) > Math.abs(prevX-mouseX) )
                            if ( mouseY > prevY) {        // Swipe Down
                                if ( !multiSwipe.running )
                                    multiSwipe.start()
                                else {
                                    multiSwipe.stop()
                                    functions.instantDown()
                                    //console.log("Double Down")
                                }

                            } else {                        // Swipe Up
                                functions.pause()
                                //console.log("Up")
                            }
                        else
                            if ( mouseX > prevX) {        // Swipe Right
                                functions.right()
                                //console.log("Right")
                            } else {                        // Swipe Left
                                functions.left()
                                //console.log("Left")
                            }
                }
                Timer {
                    id: multiSwipe
                    running: false
                    interval: 300
                    onTriggered: {
                        functions.down()
                    }
                }
            }
        }
    }
}
