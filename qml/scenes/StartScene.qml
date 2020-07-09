/* The start scene of the game */
import Felgo 3.0
import QtQuick 2.0
import "../common"

Scene {
  id: menuScene

  signal startPressed
  property alias startButton: startButton



  TexturePackerAnimatedSprite {
    id: cat
    source: "../../assets/img/catVsDog.json"
    frameNames: ["image_cat_win.png"]
    x:50
    y:90
    z:1
  }

  TexturePackerAnimatedSprite {
    id: dog
    source: "../../assets/img/catVsDog.json"
    frameNames: ["image_dog_win.png"]
    mirrorX: true
    x:250
    y:90
    z:1
  }

  TexturePackerAnimatedSprite {
    id: backgroundflash
    source: "../../assets/img/catVsDog.json"
    frameNames: ["bg_start_0.png","bg_start_1.png","bg_start_2.png"]
    anchors.fill:parent
    z:0
    frameRate: 10
  }

  TexturePackerAnimatedSprite {
    id: star1
    source: "../../assets/img/catVsDog.json"
    frameNames: ["image_level_1.png","image_level_2.png","image_level_3.png"]
    x:180
    y:40
    z:1
    frameRate: 10
  }

  TexturePackerAnimatedSprite {
    id: star2
    source: "../../assets/img/catVsDog.json"
    frameNames: ["image_level_1.png","image_level_2.png","image_level_3.png"]
    x:220
    y:30
    z:1
    frameRate: 10
  }

  TexturePackerAnimatedSprite {
    id: star3
    source: "../../assets/img/catVsDog.json"
    frameNames: ["image_level_1.png","image_level_2.png","image_level_3.png"]
    x:260
    y:40
    z:1
    frameRate: 10
  }

  Text {
      id: title
      font.family: font_nhayday.name
      font.pixelSize: 24
      text: qsTr("FLEABAG VS. MUTT")
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 60
      anchors.horizontalCenter: parent.horizontalCenter
      z:1
  }

   MenuButton {
       id:startButton
       width: 150
       height: 40

       anchors.bottom: parent.bottom
       anchors.bottomMargin: 10
       anchors.horizontalCenter: parent.horizontalCenter
       buttonText.text: qsTr("START")
       onClicked:startPressed()

   }
}
