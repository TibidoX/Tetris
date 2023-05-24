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
import ".."

Page {
    Functions {
        id: functions
    }

    id: page
    property int scoreValue
    property real difficulty: 500
    property int activeBlock
    property int futureBlock: -1

    // 0 = l_normal; 1 = l_reverse;
    // 2 = s_normal; 3 = s_reverse;
    // 4 = t_normal; 5 = square;
    // 6 = line

    property variant activeColor
    property variant futureColor

    property real centerX
    property real centerY

    Timer {
        id: downTimer
        interval: difficulty//difficulty*(1338*Math.pow(Math.E,-0.26*level)+150)
        repeat: true
        running: false
        onTriggered: {
            functions.flow()
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
            text: qsTr("Score ") + scoreValue + "\n"
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
