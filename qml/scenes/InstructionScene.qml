/* A simple scene:
 * This Scene is used to instruct this game,tell the players
 * how to play.And introduce the use of game props to players.
 */
import QtQuick 2.12
import Felgo 3.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import ".."
import "../common"
// INSTRUCTION SCENE


Scene {
    id:instructionScene

     signal startPressed
    //background
    Image {
        anchors.fill: parent
        id:background
        z:-2
        source: "../../assets/img/bg_guid.png"
    }


    // decorative animation
     TexturePackerAnimatedSprite {
        id:smileCat
        source: "../../assets/img/catVsDog.json"
        frameNames: ["image_animation_cat_smile_1.png", "image_animation_cat_smile_2.png", "image_animation_cat_smile_3.png", "image_animation_cat_smile_4.png","image_animation_cat_smile_5.png", "image_animation_cat_smile_6.png", "image_animation_cat_smile_7.png", "image_animation_cat_smile_8.png","image_animation_cat_smile_9.png", "image_animation_cat_smile_10.png"]
        frameRate: 6
        interpolate: false
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter:parent.verticalCenter
    }


     // "let's play" button,press it then you can choose game pattern
    MenuButton{
        id:gameButton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        width: 150
        height: 30
        buttonText.text: qsTr("LET'S PLAY")
        onClicked: startPressed()
    }

}
