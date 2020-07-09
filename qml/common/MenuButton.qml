/* This button is used to set scene button. */
import Felgo 3.0
import QtQuick 2.0

Item {
    id:button

    property alias buttonText: buttonText
    property alias mouseArea: mouseArea
    property alias buttonSound: buttonSound

    signal clicked

    SoundEffect {
        id: buttonSound
        source: "../../assets/snd/click.wav"
    }

    TexturePackerAnimatedSprite{
        id:bg
        source:"../../assets/img/catVsDog.json"
        frameNames: ["button_play_0.png"]
        anchors.fill: parent
    }

    Text {
        id: buttonText
        anchors.centerIn: parent
        font.family: font_nhayday.name
        font.pixelSize: 20
        color: "black"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered:
        {
            button.state="entered"
            buttonSound.play()
        }
        onExited: button.state="exited"
        onPressed: button.opacity = 0.5
        onReleased: button.opacity = 1
        onClicked: button.clicked()
    }

    states: [

        State {
            name: "entered"
            PropertyChanges {
                target: buttonText
                color:"yellow"
                font.pixelSize:22
            }
            PropertyChanges {
                target: bg
                frameNames: ["button_play_1.png"]
            }
        },
        State {
            name: "exited"
            PropertyChanges {
                target: buttonText
                color:"black"
                font.pixelSize:20
            }
            PropertyChanges {
                target: bg
                frameNames: ["button_play_0.png"]
            }
        }
    ]
}
