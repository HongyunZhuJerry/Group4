/* This button is used to set scene button with image. */
import QtQuick 2.0
import Felgo 3.0

Rectangle {
  id: button

  width: buttonText.width + paddingHorizontal * 2
  height: buttonText.height + paddingVertical * 2
  color: "yellow"
  radius: 10

  property int paddingHorizontal: 20
  property int paddingVertical: 5

  // access the text of the Text component
  property alias buttonText: buttonText
  property alias text: buttonText.text
  property alias label: label
  property bool active: false

  // this handler is called when the button is clicked.
  signal clicked

  Image {
    id: label
    anchors.centerIn: parent
    width: parent.width
    height: parent.height
  }

  Text {
    id: buttonText
    anchors.centerIn: parent
    font.pixelSize: 25
    color: "black"
  }

  SoundEffect {
      id: buttonSound
      source: "../../assets/snd/click.wav"
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    onClicked: button.clicked()
    onPressed: button.opacity = 0.5
    onReleased: button.opacity = 1
    onEntered: {
        buttonText.color = "yellow"
        buttonSound.play()
        label.scale = 0.7
    }
    onExited:{
        buttonText.color = "black"
        buttonSound.stop()
        label.scale = 1
    }
  }

}



