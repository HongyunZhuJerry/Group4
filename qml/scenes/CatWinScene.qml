/* A simple scene:
 * Cat win the game,and you can choose replay or exit.
 */
import QtQuick 2.0
import Felgo 3.0
import "../common"
SceneBase {
    signal replay
    Image {
        id: board
        width: parent.width*3/4
        height:parent.height*3/4
        source: "../../assets/img/gameoverbk.png"
        anchors.horizontalCenter: parent.horizontalCenter
        y:50


        TexturePackerAnimatedSprite{
              width: 70
              height: 70
              anchors.left: parent.left
              anchors.top: parent.top
              anchors.leftMargin: 20
              anchors.topMargin: 20
              id:winCat
              source: "../../assets/img/catVsDog.json"
              frameNames: ["image_animation_cat_win_1.png","image_animation_cat_win_2.png","image_animation_cat_win_3.png","image_animation_cat_win_4.png","image_animation_cat_win_5.png","image_animation_cat_win_6.png","image_animation_cat_win_7.png","image_animation_cat_win_8.png"]
              frameRate: 6
       }

       Text{
             id:winner
             text: "FLEABAG WINS!"
             font.family: font_nhayday.name
             font.pixelSize: 30
             anchors.left: winCat.right
             anchors.leftMargin: 10
             anchors.top: parent.top
             anchors.topMargin: 50
       }

        PlayButton{
            id:replaybutton
            text: "replay"
            buttonText.font.family: font_nhayday.name
            buttonText.font.pixelSize: 30
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            y:120
            onClicked: replay()
        }

        Text{
              id:group
              text: "Group04"
              font.family: font_nhayday.name
              font.pixelSize: 20
              anchors.bottom:  parent.bottom
              anchors.bottomMargin: 15
              anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
