import Felgo 3.0
import QtQuick 2.0

// main base for all scenes
Scene {
    id: sceneBase
    width: 480
    height: 320
    Image {
        id: background0
        source: "../../assets/img/bg_screen_game_dogcat.png"
        anchors.fill: parent
    }

    Rectangle{
        id:background1
        color: "#FFE153"
        opacity: 0.6
        anchors.fill: parent
    }

}
