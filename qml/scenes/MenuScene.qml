import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../common"

SceneBase {
    id:menuScene

    signal guidPressed
    signal gamePressed

    Image {
           id: titleBackGround
           source: "../../assets/img/button_background_0.png"
           width: 420
           height: 50
           anchors.top: parent.top
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.topMargin: 10

           Text {
               id: title
               font.family: font_nhayday.name
               font.pixelSize: 34
               text: qsTr("FLEABAG VS. MUTT")
               anchors.centerIn: parent
           }
           TexturePackerAnimatedSprite {
                  id: catSprite
                  source: "../../assets/img/catVsDog.json"
                  width: 40
                  height:parent.height
                  frameNames: ["image_animation_cat_smile_1.png","image_animation_cat_smile_2.png",
                      "image_animation_cat_smile_3.png","image_animation_cat_smile_4.png",
                      "image_animation_cat_smile_5.png","image_animation_cat_smile_6.png",
                      "image_animation_cat_smile_7.png","image_animation_cat_smile_8.png",
                      "image_animation_cat_smile_9.png","image_animation_cat_smile_10.png"]
                  interpolate: false
                  anchors.left: parent.left
                  anchors.leftMargin: 20
                  frameRate: 3
                }
           TexturePackerAnimatedSprite {
                  id: dogSprite
                  source: "../../assets/img/catVsDog.json"
                  width: 40
                  height:parent.height
                  frameNames: ["image_animation_dog_smile_1.png","image_animation_dog_smile_2.png"]
                  interpolate: false
                  anchors.right: parent.right
                  anchors.rightMargin: 20
                  frameRate: 3
                }
         }

    Column{
        anchors.top: parent.top
        anchors.topMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter
        Row{
            TexturePackerAnimatedSprite {
                   id: cat
                   width: 40
                   height: 40
                   source: "../../assets/img/catVsDog.json"
                   frameNames: ["image_animation_cat_prepare_11.png"]
                 }
            Text {
                id: part0
                font.family: font_nhayday.name
                font.pixelSize: 18
                text: qsTr("FLEABAG AND ")
            }
            TexturePackerAnimatedSprite {
                   id: dog
                   width: 32
                   height: 32
                   source: "../../assets/img/catVsDog.json"
                   frameNames: ["image_animation_dog_seat.png"]
                 }
            Text {
                id: part1
                font.family: font_nhayday.name
                font.pixelSize: 18
                text: qsTr(" MUTT ARE AT IT AGAIN! ")
            }
        }
        TextArea{
            id: part2
            font.family: font_nhayday.name
            font.pixelSize: 16
            text: qsTr("IT'S A WINDY DAY AND THEY ARE THROEING STUFF OVER \nTHE FENCE AT EATH OTHER UNTIL ONE OF THEM GIVES UP.\nWHO 'S GONNA BE THE WINNER ON THIS WINDY DAY?")
        }
    }

    Column{
        // "how to play" button,press it then you can get the instruction about the game
        anchors.top: parent.top
        anchors.topMargin: 210
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5
        MenuButton{
            id:guidButton
            width: 200
            height: 40
            buttonText.text: qsTr("HOW TO PLAY")
            onClicked: guidPressed()

        }
        // "let's play" button,press it then you can choose game pattern
        MenuButton{
            id:gameButton
            width: 200
            height: 40
            buttonText.text: qsTr("LET'S PLAY")
            onClicked: gamePressed()
        }
    }


}
