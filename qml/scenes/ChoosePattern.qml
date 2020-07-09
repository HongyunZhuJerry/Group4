/* This scene is used to choose the game pattern.
 * There are two options: free mode and classic mode.
 */
import QtQuick 2.0
import Felgo 3.0
import "../common"
// EMPTY SCENE

SceneBase {
    signal freePatternPressed
    signal classicPatternPressed
    signal exitPressed
    property alias exitButton: exit

    Image {
        id: board
        width: parent.width*3/4
        height:parent.height*3/4
        source: "../../assets/img/gameoverbk.png"
        anchors.horizontalCenter: parent.horizontalCenter
        y:50

        Text {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20
            font.family: font_nhayday.name
            font.pixelSize: 30
            id: choose
            text:"Choose game"
        }
        Column{
            anchors.top: choose.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            PlayButton{
                //label.source: "../../assets/img/dogoneplayer.png"
                text:"Free Pattern"
                buttonText.font.family:digital_7.name
                color: "transparent"
                onClicked: {
                    freePatternPressed()
                }
            }
            spacing: 10

            PlayButton{
                //label.source: "../../assets/img/twoplayer.png"
                text: "Classic Pattern"
                buttonText.font.family:digital_7.name
                color: "transparent"
                onClicked: {
                    classicPatternPressed()
                }
            }
        }
        PlayButton{
            id:exit
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Exit"
            buttonText.font.family:font_nhayday.name
            buttonText.font.pixelSize: 30
            color: "transparent"
            onClicked: {
                exitPressed()
            }
        }
    }
    TexturePackerAnimatedSprite {
       id:smileCat
       anchors.horizontalCenter: parent.horizontalCenter
       source: "../../assets/img/catVsDog.json"
       frameNames: ["image_dogcat_over.png","image_dogcat.png"]
       frameRate: 3
       interpolate: false
       anchors.bottom: board.top
       //anchors.bottomMargin: 20
   }
}
