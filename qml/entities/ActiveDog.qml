import Felgo 3.0
import QtQuick 2.0

EntityBase {
    id:dog1
    entityId: "dog1"
    entityType: "dog"

    property alias collider: collider
    property alias horizontalVelocity: collider.linearVelocity.x

//    property int contacts: 0

//    state: contacts > 0 ? "walking" : "jumping"
//    onStateChanged: console.debug("player.state " + state)


//    BoxCollider{
//        id:boxCollider
//        width:55
//        height: 65

//        bodyType: Body.Static

//    }
    MultiResolutionImage {
      source: "../../assets/img/image_animation_dog_seat.png"
      height:40
      width:30
    }

    BoxCollider {
      id: collider
      height: parent.height
      width: 30
      anchors.horizontalCenter: parent.horizontalCenter
      // this collider must be dynamic because we are moving it by applying forces and impulses
      bodyType: Body.Dynamic // this is the default value but I wanted to mention it ;)
      fixedRotation: true // we are running, not rolling...
      bullet: true // for super accurate collision detection, use this sparingly, because it's quite performance greedy
      sleepingAllowed: false
      // apply the horizontal value of the TwoAxisController as force to move the player left and right
      force: Qt.point(controller2.xAxis*100*32,0)
      // limit the horizontal velocity
      onLinearVelocityChanged: {
        if(linearVelocity.x > 100) linearVelocity.x = 100
        if(linearVelocity.x < -100) linearVelocity.x = -100
      }
    }
    Timer {
      id: updateTimer
      // set this interval as high as possible to improve performance, but as low as needed so it still looks good
      interval: 60
      running: true
      repeat: true
      onTriggered: {
        var xAxis = controller2.xAxis;
        // if xAxis is 0 (no movement command) we slow the player down until he stops
        if(xAxis == 0) {
          if(Math.abs(dog1.horizontalVelocity) > 10) dog1.horizontalVelocity /= 1.5
          else dog1.horizontalVelocity = 0
        }
      }
    }

    function jump() {
//      console.debug("jump requested at player.state " + state)
      if(dog1.y>240&&(dog1.x<180||dog1.x>270)) {
//        console.debug("do the jump")
        // for the jump, we simply set the upwards velocity of the collider
        collider.linearVelocity.y = -200
      }
    }

}

