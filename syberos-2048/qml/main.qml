import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import com.syberos.basewidgets 2.0
//import com.syberos.basewidgets 1.0
import "2048.js" as MyScript

CPageStackWindow {
    id: mainPageView
    inputFactor: 0

    initialPage:CPage{
        id: startPage
        anchors.fill: parent
        orientationLock: CPageOrientation.LockPortrait
        property var begin_x
        property var begin_y
        property var moviDirection
    //    property var scale: 1.8

//        ExclusiveGroup { id: labelSettingsGroup }
//        ExclusiveGroup { id: languageSettingsGroup }

        MouseArea {
            anchors.fill: parent

            property var begin_x
            property var begin_y
            property var moviDirection

            onPressed: {
                begin_x = mouseX;
                console.log("---syberos2048----begin_x-----------",begin_x);
                begin_y = mouseY
                console.log("---syberos2048----begin_y-----------",begin_y);
            }

            onReleased: {
                var d_x = mouseX - begin_x;
                if (d_x < 0) {
                    d_x = -d_x;
                }

                var d_y = mouseY - begin_y;
                if (d_y < 0) {
                    d_y = -d_y;
                }

                var d_Temp = d_x - d_y;
                console.log("---syberos2048----onReleased----------d_x:", d_x);
                console.log("---syberos2048----onReleased----------d_y:", d_y);
                console.log("---syberos2048----onReleased----------d_Temp:", d_Temp);

                if ((mouseX > begin_x) && (d_Temp > 0)) {
                    moviDirection = "Key_Right"
                    console.log("---syberos2048----Key_Right-----------");
                } else if ((mouseX < begin_x) && (d_Temp > 0)) {
                    moviDirection = "Key_Left"
                    console.log("---syberos2048----Key_Left-----------");
                } else if ((mouseY < begin_y) && (d_Temp < 0)) {
                    moviDirection = "Key_Up"
                    console.log("---syberos2048----Key_Up-----------");
                } else if ((mouseY > begin_y) && (d_Temp < 0)) {
                    moviDirection = "Key_Down"
                    console.log("---syberos2048----Key_Down-----------");
                }

                MyScript.moveKey(moviDirection)
            }
        }


        Item {
            id: helper
            focus: false
            property var myColors: {"bglight": "#FAF8EF",
                                    "bggray": Qt.rgba(238/255, 228/255, 218/255, 0.35),
                                    "bgdark": "#BBADA0",
                                    "fglight": "#EEE4DA",
                                    "fgdark": "#776E62",
                                    "bgbutton": "#8F7A66", // Background color for the "New Game" button
                                    "fgbutton": "#F9F6F2" // Foreground color for the "New Game" button
            }
        }

    //    color: helper.myColors.bglight

        Item {
            anchors.fill: parent
            anchors.topMargin: 100
            focus: true

            Component.onCompleted: {
                console.log("---syberos2048----width-----------",width);
                console.log("---syberos2048----height-----------",height);
            }

            FontLoader { id: localFont; source: "qrc:///fonts/DroidSansFallback.ttf" }

            Text {
                id: gameName
                anchors.top: parent.top
                anchors.topMargin: 40
                anchors.left: parent.left
                anchors.leftMargin: 50
                font.family: localFont.name
                font.pixelSize: 70//55*scale
                font.bold: true
                text: "2048"
                color: helper.myColors.fgdark
            }

            Row {
                id: scoreRow
                anchors.right: parent.right
                anchors.rightMargin: 40
                anchors.top: parent.top
                anchors.topMargin: 40
                spacing: 9//5*scale
                Repeater {
                    id: scoreBoard
                    model: 2
                    Rectangle {
                        width: (index == 0) ? 171 : 225
                        height: 99//55*scale
                        radius: 5.4//3*scale
                        color: helper.myColors.bgdark
                        property string scoreText: (index === 0) ? MyScript.score.toString() : MyScript.bestScore.toString()
                        Text {
                            text: (index == 0) ? qsTr("SCORE") : qsTr("BEST")
                            anchors.horizontalCenter: parent.horizontalCenter
                            y: 10.8//6*scale
                            font.family: localFont.name
                            font.pixelSize: 23//13*scale
                            color: helper.myColors.fglight
                        }
                        Text {
                            text: scoreText
                            anchors.horizontalCenter: parent.horizontalCenter
                            y: 39.6//22*scale
                            font.family: localFont.name
                            font.pixelSize: 45//25*scale
                            font.bold: true
                            color: "white"
                        }
                    }
                }

                Text {
                    id: addScoreText
                    font.family: localFont.name
                    font.pixelSize: 45
                    font.bold: true
                    color: Qt.rgba(119/255, 110/255, 101/255, 0.9);
                    anchors.horizontalCenter: parent.horizontalCenter

                    property bool runAddScore: false
                    property real yfrom: 0
                    property real yto: -(parent.y + parent.height)
                    property int addScoreAnimTime: 600

                    ParallelAnimation {
                        id: addScoreAnim
                        running: false

                        NumberAnimation {
                            target: addScoreText
                            property: "y"
                            from: addScoreText.yfrom
                            to: addScoreText.yto
                            duration: addScoreText.addScoreAnimTime

                        }
                        NumberAnimation {
                            target: addScoreText
                            property: "opacity"
                            from: 1
                            to: 0
                            duration: addScoreText.addScoreAnimTime
                        }
                    }
                }
            }

            CButton {
                id: newBtn
                width: 232.2
                height: 72
                anchors.top: scoreRow.bottom
                anchors.topMargin: 40
                anchors.right: parent.right
                anchors.rightMargin: 40

                backgroundComponent: Rectangle {
                    color: helper.myColors.bgbutton
                    radius: 5.4
                    Text{
                        anchors.centerIn: parent
                        text: qsTr("New Game")
                        color: helper.myColors.fgbutton
                        font.family: localFont.name
                        font.pixelSize: 32
                        font.bold: true
                    }
                }
                onClicked: MyScript.startupFunction()
            }

            Rectangle {
                id: gameCenter
                anchors.top: newBtn.bottom
                anchors.topMargin: 40
                anchors.left: parent.left
                anchors.leftMargin: 10

                width: 700
                height: 700
                color: helper.myColors.bgdark
                radius: 6

                Grid {
                    id: tileGrid
                    x: 15;
                    y: 15;
                    rows: 4; columns: 4; spacing: 20

                    Repeater {
                        id: cells
                        model: 16
                        Rectangle {
                            width: 600/4;height:600/4
                            radius: 3
                            color: helper.myColors.bggray
                        }
                    }
                }
            }

            Text {
                id: banner
                anchors.top: gameCenter.bottom
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 20
                height: 72
                text: qsTr("Join the numbers and get to <b>2048 tile</b>!")
                color: helper.myColors.fgdark
                font.family: localFont.name
                font.pixelSize: 40
                verticalAlignment: Text.AlignVCenter
            }

            CDialog{
                id:deadMessage
                messageText: qsTr("Game Over!")
                onAccepted:{
                    MyScript.startupFunction();
                }

                onRejected: {
                    MyScript.cleanUpAndQuit();
                }
            }

            CDialog{
                id:winMessage
                messageText: qsTr("You win! Continue playing?")
                onAccepted:{
                    MyScript.checkTargetFlag = false;
                    close()
                }

                onRejected: {
                    MyScript.checkTargetFlag = false;
                    close()
                }
            }
        }
    }

    Component.onCompleted: MyScript.startupFunction();
}

