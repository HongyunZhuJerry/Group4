import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "../common"


Scene {
  id: gameScene

  property int catlife: 10
  property int doglife: 10
  property int time1
  property int time2
  signal catWinScene
  signal dogWinScene
  signal back

  function initStates(){
      //Initialize the health of cats and dogs
      catlife=10
      doglife=10
      console.log("catlift"+gameScene.catLife)

      cat1.x=45
      cat1.y=195
      dog1.x=345
      dog1.y=195
      //Initialize cat and dog blood bars
      bloodcat.width= 190.9
      bloodcat.x=12.2
      blooddog.width=192
      blooddog.x=275
  }

  Rectangle{
      id:background1
      color: "#2C6A8E"
      opacity: 1
      anchors.fill: parent
      z:-2
  }

  //ground image
  Image {
      id: layer1
      source: "../../assets/img/layer1.png"
      y:275
      z:-1
      width: 480
      height: 30
  }
  Image {
      id: layer2
      source: "../../assets/img/layer2.png"
      y:218
      z:-1
      width: 480
      height: 100
  }

  Image {
      id: ground1
      source: "../../assets/img/mid.png"
      height: 18
      width:30
      y:288
      x:0
  }

  Image {
      id: ground2
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:18
  }

  Image {
      id: ground3
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:36
  }

  Image {
      id: ground4
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:54
  }

  Image {
      id: ground5
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:72
  }

  Image {
      id: ground6
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:90
  }

  Image {
      id: ground7
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:108
  }

  Image {
      id: ground8
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:126
  }

  Image {
      id: ground9
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:144
  }

  Image {
      id: ground10
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:162
  }

  Image {
      id: ground11
      source: "../../assets/img/mid.png"
      height: 18
      width:30
      y:288
      x:300
  }

  Image {
      id: ground12
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:318
  }

  Image {
      id: ground13
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:336
  }

  Image {
      id: ground14
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:354
  }

  Image {
      id: ground15
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:372
  }

  Image {
      id: ground16
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:390
  }

  Image {
      id: ground17
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:408
  }

  Image {
      id: ground18
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:426
  }

  Image {
      id: ground19
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:444
  }

  Image {
      id: ground20
      source: "../../assets/img/mid.png"
      height: 18
      width:18
      y:288
      x:462
  }

  EntityManager {id:entityManager; entityContainer: gameScene}

  Keys.forwardTo: [controller1, controller2]

  ActiveCat {
      id:cat1
      width:30
      height:40
      x:45
      y:195
      z:1
      TwoAxisController {
          id: controller1
          inputActionsToKeyCode: {
              "up": Qt.Key_Up,
              "down": Qt.Key_Down,
              "left": Qt.Key_Left,
              "right": Qt.Key_Right,
              "fire": Qt.Key_0
          }
          onInputActionPressed: {
              console.debug("key pressed actionName " + actionName)
            if(actionName == "up") {
              cat1.jump()
            }
            //onPressed timer start, determines the strength
            if(actionName == "fire") {
                time1 = 0
                timercat.start()
            }
          }
                  //onReleased fire
          onInputActionReleased: {
              if(actionName == "fire"){
                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Lover.qml"), {"start" : Qt.point(cat1.x+32, cat1.y-20),"time":time1,"who":"cat","isWitch":0,"width":25,"height":25})
            }
          }
      }
      onYChanged:{
          if(y>250) dogWinScene()
      }
  }
//The length of the cat’s throwing pressure determines the strength
  Timer{
      id:timercat
      interval: 250
      repeat: true
      triggeredOnStart: true
      onTriggered: {
          time1++
      }
  }

  onCatlifeChanged: {
      bloodcat.width = bloodcat.width-19.09
      bloodcat.x = bloodcat.x+19.09
      if(catlife<=0){
          console.log("cat lose")
          dogWinScene()
      }
  }


  ActiveDog {
      id:dog1
      width:30
      height:40
      x:345
      y:195
      z:1
      TwoAxisController {
        id: controller2
        //move by WASD
        inputActionsToKeyCode: {
                           "up": Qt.Key_W,
                           "down": Qt.Key_S,
                           "left": Qt.Key_A,
                           "right": Qt.Key_D,
                           "fire": Qt.Key_Space
                       }
        onInputActionPressed: {
            console.debug("key pressed actionName " + actionName)
          if(actionName == "up") {
            dog1.jump()
          }
          //onPressed timer start, determines the strength
          if(actionName == "fire") {
              time2 = 0
              timerdog.start()
          }
        }
        //onReleased fire
        onInputActionReleased: {
            if(actionName == "fire"){
              entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Lover.qml"), {"start" : Qt.point(dog1.x-32, dog1.y-20),"time":time2,"who":"dog","isWitch":0,"width":28,"height":23})
          }
        }
      }
      onYChanged:{
          if(y>250) catWinScene()
      }
  }

  //The length of the dog’s throwing pressure determines the strength
  Timer{
      id:timerdog
      interval: 250
      repeat: true
      triggeredOnStart: true
      onTriggered: {
          time2++
      }
  }

  onDoglifeChanged: {
      blooddog.width -= 19.2
      if(doglife<=0){
          console.log("dog lose")
          catWinScene()
      }
  }


  //blood control
  TexturePackerAnimatedSprite {
      id: title
      source: "../../assets/img/catVsDog.json"
      frameNames: ["image_dogcat.png"]
      width:95
      height:40
      x:192.2
      y:2
      z:1
  }

  TexturePackerAnimatedSprite{
      id: blood
      source: "../../assets/img/catVsDog.json"
      frameNames: ["bg_blood.png"]
      width:460
      height:20
      x:10
      y:25
  }

  TexturePackerAnimatedSprite {
      id: bloodcat
      source: "../../assets/img/catVsDog.json"
      frameNames: ["bg_blood_cat.png"]
      width:190.9
      height:12.8
      x:12.2
      y:28.5
  }

  TexturePackerAnimatedSprite {
      id: blooddog
      source: "../../assets/img/catVsDog.json"
      frameNames: ["bg_blood_dog.png"]
      width:192
      height:12.8
      x:275
      y:28.5
  }

  //border
  Wall{
      y:285

      boxCollider.width: 180
      boxCollider.height: 3
  }

  Wall{
      y:285
      x:300
      boxCollider.width: 180
      boxCollider.height: 3
  }

  Wall{
      x:0
      boxCollider.width: 3
      boxCollider.height: 300
  }

  Wall{
      x:477
      boxCollider.width: 3
      boxCollider.height: 300
  }

  PlayButton{
      width: 20
      height: 20
      label.source: "../../assets/img/button_back.png"
      anchors.top: parent.top
      anchors.right: parent.right
      color: "transparent"
      onClicked: {
          back()
      }
  }

//  PhysicsWorld {
//      id:physicsworld
//      debugDrawVisible: true
//      updatesPerSecondForPhysics:0
//      gravity.y:10
//  }
}
