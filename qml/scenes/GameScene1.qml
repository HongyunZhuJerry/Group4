import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "../common"

Scene {
  id: gameScene

  //Timer time
  property int initTime: 0
  property int waitTime: 0
  property int countTime: 0
  //cat/dog's life
  property int catLife: 10
  property int dogLife: 10
  //Distinguish between cat and dog rounds
  property int isTurn: 2
  //Distinguish whether the corresponding button is pressed
  property int isPower: 0
  property int isBomb: 0
  property int isDouble: 0
  //wind's value
  property int exwind:0
  property double wind:0.0

  property alias bloodcat: bloodcat
  property alias blooddog: blooddog
  property alias dogSprite: dogSprite


  signal catTurn
  signal catWinScene

  signal dogTurn
  signal dogWinScene

  signal clockOn
  signal clockOff
  signal wallHit
  signal getWind
  signal minusBlood
  signal addBlood
  signal butttonEnable
  signal again
  signal back
  signal preSliderOn
  signal preSliderOff

  //The initial state of the game
  function initStates(){
      //Cat throws first
      catTurn()
      dogSprite.jumpTo("dogseathold")
      catSprite.jumpTo("catprepare")
      //Initialize the health of cats and dogs
      catLife=10
      dogLife=10
      console.log("catlift"+gameScene.catLife)
      //Initialize cat and dog blood bars
      bloodcat.width= 190.9
      bloodcat.x=12.2
      blooddog.width=192
      blooddog.x=275
      //Initialize the buttons for cats and dogs
      incatBlood.opacity=1
      incatPower.opacity=1
      incatDouble.opacity=1
      incatBomb.opacity=1
      indogBomb.opacity=1
      indogDouble.opacity=1
      indogPower.opacity=1
      indogBlood.opacity=1


  }

  //Force display when pressing cat or dog
  onPreSliderOn: {
      bgpreslider.visible = true
      preslider.visible=true
      presliderwidth.start()
  }

  //The force bar disappears when the cat or dog is released
  onPreSliderOff: {
      bgpreslider.visible=false
      preslider.visible=false
      presliderwidth.stop()
  }

  //When it’s the turn of the cat or dog, their buttons become enabled, while the other party’s buttons become disabled
  onButttonEnable: {
      if(isTurn==1){
          incatBlood.enabled=true
          incatPower.enabled=true
          incatDouble.enabled=true
          incatBomb.enabled=true
          indogBomb.enabled=false
          indogDouble.enabled=false
          indogPower.enabled=false
          indogBlood.enabled=false
      }else if(isTurn==0){
          incatBlood.enabled=false
          incatPower.enabled=false
          incatDouble.enabled=false
          incatBomb.enabled=false
          indogBomb.enabled=true
          indogDouble.enabled=true
          indogPower.enabled=true
          indogBlood.enabled=true
      }
  }

  //Add blood to cats or dogs
  onAddBlood: {
      if(isTurn==1){
          //Change life value
          catLife += 2
          //Change blood bar
          if(catLife>10) {
              catLife=10
              bloodcat.width=190.9
              bloodcat.x=12.2
          }else{
              bloodcat.width = bloodcat.width+2*19.09
              bloodcat.x = bloodcat.x-2*19.09
          }
          catSprite.jumpTo("catseathold")
          dogTurn()
          dogSprite.jumpTo("dogprepare")
      }else if(isTurn==0){
          //Change life value
          dogLife += 2
          //Change blood bar
          if(dogLife>10){
              dogLife=10
              blooddog.width=192
          }else{
              blooddog.width = blooddog.width+2*19.2
          }
          dogSprite.jumpTo("dogseathold")
          catTurn()
          catSprite.jumpTo("catprepare")
      }
  }

  //"x2 button" to achieve the same track throw twice
  onAgain: {
      if(isTurn==1){
          entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Lover.qml"), {"start" : Qt.point(90, 195),"time":initTime,"who":"cat","isWitch":1,"width":20,"height":20})
      }else{
          entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Lover.qml"), {"start" : Qt.point(360,220),"time":initTime,"who":"dog","isWitch":1,"width":25,"height":20})
      }


  }

  //After the wall is smashed, the rotation of cats and dogs is realized, and the corresponding animation is played.
  onWallHit: {
      if(isTurn==1){
          dogSprite.jumpTo("dogsmile")
          if(isDouble==1){
              catSprite.jumpTo("catthrow")
              again()
              isDouble=0
          }else{
              dogTurn()
          }
          dogSmiling.play()
          turn.opacity=1
      }
      else if(isTurn==0){
          catSprite.jumpTo("catsmile")
          if(isDouble==1){
              dogSprite.jumpTo("dogthrow")
              again()
              isDouble=0
          }else{
              catTurn()
          }
          catSmiling.play()
      }
  }

  //When cats or dogs are smashed, their lifes calue and blood bars change
  onMinusBlood: {
      if(isTurn==0){
          catLife--
          bloodcat.width = bloodcat.width-19.09
          bloodcat.x = bloodcat.x+19.09
          if(isPower==1||isBomb==1){
              catLife--
              bloodcat.width = bloodcat.width-19.09
              bloodcat.x = bloodcat.x+19.09
          }
      }else if(isTurn==1){
          dogLife--
          blooddog.width -= 19.2
          if(isPower==1||isBomb==1){
              dogLife--
              blooddog.width -= 19.2
          }
      }
  }

  //Each round, the wind speed changes, and the value of the wind speed is random
  onGetWind: {
      exwind = utils.generateRandomValueBetween(-5, 5)
      wind = exwind/2
      console.log(wind)
      if(wind>0){
          imgwindright.visible=true
          imgwindleft.visible=false
          windright.width = 20*wind
          windright.visible=true
          windleft.visible=false
      }else if(wind <0){
          imgwindleft.visible=true
          imgwindright.visible=false
          windleft.width = 20*(-wind)
          windleft.x = 208+10*(2+wind)
          windright.visible=false
          windleft.visible=true
      }else if(wind==0){
          imgwindleft.visible=false
          imgwindright.visible=false
          windleft.width = 3
          windleft.x = 235
          windright.visible=false
          windleft.visible=true
      }
  }

  //Cat throwing
  onCatTurn: {
      isTurn=1
      console.log(isTurn)
      butttonEnable()
      countTime=0
      countdown.start()
      catSprite.enabled=true
      dogSprite.enabled=false
      turn.visible=true
      getWind()
  }

  //Dog throwing
  onDogTurn: {
      isTurn=0
      console.log(isTurn)
      butttonEnable()
      countTime=0
      countdown.start()
      dogSprite.enabled=true
      catSprite.enabled=false
      turn.visible=true
      getWind()
  }

  //The clock used to record the waiting countdown starts
  onClockOn:{
      if(isTurn==1){
          bgSprite.visible=true
          bgSprite.jumpTo("catclock")
      }else{
          bgSprite.visible=true
          bgSprite.jumpTo("dogclock")
      }
  }

  //The clock used to record the waiting countdown stops counting
  onClockOff:{
      bgSprite.visible=false
      countdown.stop()
  }

    EntityManager {id:entityManager; entityContainer: gameScene}

  Cat{
      id:cat
      width:50
      height:60
      x:47
      y:195
      z:1
      //Cat will play animations when smashed and dog will laugh
      onCatHitted: {
          minusBlood()
          catSprite.jumpTo("catinjure1")
          if(isDouble==1&&catLife!=0){
              again()
              isDouble=0
          }else{
              catTurn()
          }
          if(catLife<=0){
              catSprite.jumpTo("catlose")
              dogSprite.jumpTo("dogwin")
              showResult.start()
          }
        }
      onDoglaugh:{
          dogSmiling.play()
          catCry.play()
          dogSprite.jumpTo("dogsmilehit")
      }
  }

  //The waiting time for cat/dogwinscene
  Timer{
      id:showResult
      interval: 1000
      repeat: true
      triggeredOnStart: true
      onTriggered: {
          turn.visible=false
          countdown.stop()
          waitTime++
          if(waitTime==5){
              showResult.stop()
              if(catLife<=0){
                  console.log("dogwin")
                  dogWinScene()
              }
              else catWinScene()
          }
      }
  }

  Dog{
      x:390
      y:220
      //Dog will play animations when smashed and cat will laugh
      onDogHitted: {
          minusBlood()
          dogSprite.jumpTo("doginjure1")
          if(isDouble==1&&dogLife!=0){
              again()
              isDouble=0
          }else{
              dogTurn()
          }
//          dogTurn()
          if(dogLife<=0){
              dogSprite.jumpTo("doglose")
              catSprite.jumpTo("catwin")
              showResult.start()
          }
      }
      onCatlaugh:{
          catSmiling.play()
          dogCry.play()
          catSprite.jumpTo("catsmilehit")
      }
      z:1
  }

  TexturePackerSpriteSequence {
         id: catSprite
         width:50
         height:60
         x:45
         y:195
         z:1
         enabled: false

         TexturePackerSprite {
             name: "catseathold"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_seat.png"]
         }


         TexturePackerSprite {
             name: "catseat"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_seat.png"]
             to:{"catprepare":1}
         }

         TexturePackerSprite {
             name: "catprepare"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_prepare_1.png","image_animation_cat_prepare_2.png","image_animation_cat_prepare_3.png","image_animation_cat_prepare_4.png","image_animation_cat_prepare_5.png","image_animation_cat_prepare_6.png","image_animation_cat_prepare_7.png","image_animation_cat_prepare_8.png"]
             x:-10
             y:10
             frameRate: 6
             to:{"catpreparehold2":1}
         }

         TexturePackerSprite {
             name: "catpreparehold2"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_prepare_9.png","image_animation_cat_prepare_10.png","image_animation_cat_prepare_11.png","image_animation_cat_prepare_12.png","image_animation_cat_prepare_13.png"]
             x:-10
             y:10
             frameRate: 6
             to:{"catpreparehold3":1}
         }

         TexturePackerSprite {
             name: "catpreparehold3"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_prepare_13.png"]
             x:-10
             y:10
             frameRate: 6
         }

         TexturePackerSprite {
             name: "catthrow"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_throw_1.png","image_animation_cat_throw_2.png","image_animation_cat_throw_3.png","image_animation_cat_throw_4.png"]
             frameRate: 6
             to:{"catseathold":1}
         }

         TexturePackerSprite {
             name: "catwin"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_win_1.png","image_animation_cat_win_2.png","image_animation_cat_win_3.png","image_animation_cat_win_4.png","image_animation_cat_win_5.png","image_animation_cat_win_6.png","image_animation_cat_win_7.png","image_animation_cat_win_8.png"]
             frameRate: 6
         }

         TexturePackerSprite {
             name: "catlose"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_lose_1.png","image_animation_cat_lose_2.png","image_animation_cat_lose_3.png","image_animation_cat_lose_4.png"]
             frameRate: 6
         }

         TexturePackerSprite {
             name: "catsmile"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_smile_1.png","image_animation_cat_smile_2.png","image_animation_cat_smile_3.png","image_animation_cat_smile_4.png","image_animation_cat_smile_5.png","image_animation_cat_smile_6.png","image_animation_cat_smile_7.png","image_animation_cat_smile_8.png","image_animation_cat_smile_9.png","image_animation_cat_smile_10.png"]
             frameRate: 6
             to:{"catseat":1}

         }

         TexturePackerSprite {
             name: "catsmilehit"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_smile_1.png","image_animation_cat_smile_2.png","image_animation_cat_smile_3.png","image_animation_cat_smile_4.png","image_animation_cat_smile_5.png","image_animation_cat_smile_6.png","image_animation_cat_smile_7.png","image_animation_cat_smile_8.png","image_animation_cat_smile_9.png","image_animation_cat_smile_10.png"]
             frameRate: 6
             to:{"catseathold":1}
         }

         TexturePackerSprite {
             name: "catinjure1"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_injure_1_1.png","image_animation_cat_injure_1_2.png","image_animation_cat_injure_1_3.png","image_animation_cat_injure_1_4.png","image_animation_cat_injure_1_5.png","image_animation_cat_injure_1_6.png","image_animation_cat_injure_1_7.png"]
             frameRate: 6
             to:{"catseat":1}
         }

         TexturePackerSprite {
             name: "catinjure3"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_injure_3_1.png","image_animation_cat_injure_3_2.png","image_animation_cat_injure_3_3.png","image_animation_cat_injure_3_4.png","image_animation_cat_injure_3_5.png","image_animation_cat_injure_3_6.png","image_animation_cat_injure_3_7.png","image_animation_cat_injure_3_8.png","image_animation_cat_injure_3_9.png","image_animation_cat_injure_3_10.png","image_animation_cat_injure_3_11.png","image_animation_cat_injure_3_12.png","image_animation_cat_injure_3_13.png","image_animation_cat_injure_3_14.png","image_animation_cat_injure_3_15.png","image_animation_cat_injure_3_16.png","image_animation_cat_injure_3_17.png","image_animation_cat_injure_3_18.png","image_animation_cat_injure_3_19.png","image_animation_cat_injure_3_20.png"]
             frameRate: 6

         }

         TexturePackerSprite {
             name: "catinjure4"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_cat_injure_4_1.png","image_animation_cat_injure_4_2.png","image_animation_cat_injure_4_3.png","image_animation_cat_injure_4_4.png","image_animation_cat_injure_4_5.png","image_animation_cat_injure_4_6.png","image_animation_cat_injure_4_7.png","image_animation_cat_injure_4_8.png","image_animation_cat_injure_4_9.png","image_animation_cat_injure_4_10.png","image_animation_cat_injure_4_11.png","image_animation_cat_injure_4_12.png","image_animation_cat_injure_4_13.png","image_animation_cat_injure_4_14.png","image_animation_cat_injure_4_15.png","image_animation_cat_injure_4_16.png","image_animation_cat_injure_4_17.png","image_animation_cat_injure_4_18.png","image_animation_cat_injure_4_19.png","image_animation_cat_injure_4_20.png","image_animation_cat_injure_4_21.png","image_animation_cat_injure_4_22.png","image_animation_cat_injure_4_23.png"]
             x:-5
             frameRate: 6
         }

         MouseArea {
             anchors.fill: catSprite
             onPressed: {
                 timeslider.visible=false
                 //When pressing, the timer that records the pressing time starts to count
                 initTime=0
                 timer.start()
                 //The timer that records the waiting time stops counting
                 clockOff()
                 //Progress bar showing pressing force
                 preSliderOn()

                 turn.visible=false

             }
             onReleased: {
                 //When the press is released, the timer that records the press time stops counting
                 timer.stop()
                 //The progress bar of pressing force disappears
                 preSliderOff()
                 //Create an entity to be thrown
                 if(isPower==1){

                     entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Lover.qml"), {"start" : Qt.point(90, 195),"time":initTime,"who":"cat","isWitch":1,"width":25,"height":25})
                     isPower=0
                 }else{
                     entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Lover.qml"), {"start" : Qt.point(90, 195),"time":initTime,"who":"cat","isWitch":1,"width":20,"height":20})
                 }
                //Play cat throwing animation
                 catSprite.jumpTo("catthrow")

                 catSprite.enabled=false
             }
         }
  }

  //Timer to record pressing time
  //The time of pressing is converted into the speed of the projectile, the longer the pressing event, the greater the speed
  Timer{
      id:timer
      interval: 500
      repeat: true
      triggeredOnStart: true
      onTriggered: {
          initTime++
          //Avoid pressing for too long, causing the projectile to be too fast
          if(initTime==5)
              timer.stop()
      }
  }
  //This timer records the time waiting for a cat or dog to start throwing
  Timer{
      id:countdown
      interval: 500
      repeat:true
      triggeredOnStart: true
      onTriggered: {
          countTime++
          //When the waiting time is 6s, the animation of the countdown clock plays
          if(countTime==12){
              clockOn()
              timeslider.visible=true
              timesliderwidth.start()
              turn.visible=false
          }else if(countTime==20){//When the waiting time is greater than 10s, the opponent's turn is thrown
              clockOff()
              if(isTurn==1){
                  catSprite.jumpTo("catseathold")
                  dogTurn()
                  dogSprite.jumpTo("dogprepare")
              }else{
                  dogSprite.jumpTo("dogseathold")
                  catTurn()
                  catSprite.jumpTo("catprepare")
              }
          }

      }
  }

  TexturePackerSpriteSequence {
         id: dogSprite
         width:55
         height:65
         x:385
         y:220
         z:1
         enabled: false

         TexturePackerSprite {
             name: "dogseathold"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_seat.png"]
         }

         TexturePackerSprite {
             name: "dogseat"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_seat.png"]
             to:{"dogprepare":1}
         }

         TexturePackerSprite {
             name: "dogprepare"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_prepare_1.png","image_animation_dog_prepare_2.png","image_animation_dog_prepare_3.png","image_animation_dog_prepare_4.png","image_animation_dog_prepare_5.png","image_animation_dog_prepare_6.png"]
             x:-12.5
             y:-1.5
             frameRate: 6
             to:{"dogpreparehold2":1}
         }

         TexturePackerSprite {
             name: "dogpreparehold2"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_prepare_7.png","image_animation_dog_prepare_8.png","image_animation_dog_prepare_9.png"]
             x:-12.5
             y:-1.5
             frameRate: 6
             to:{"dogpreparehold3":1}
         }

         TexturePackerSprite {
             name: "dogpreparehold3"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_prepare_9.png"]
             x:-12.5
             y:-1.5
             frameRate: 6
         }

         TexturePackerSprite {
             name: "dogthrow"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_throw_1.png","image_animation_dog_throw_2.png","image_animation_dog_throw_3.png"]
             frameRate: 6
             to:{"dogseathold":1}
         }

         TexturePackerSprite {
             name: "dogwin"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_win_1.png","image_animation_dog_win_2.png","image_animation_dog_win_3.png","image_animation_dog_win_4.png","image_animation_dog_win_5.png","image_animation_dog_win_6.png","image_animation_dog_win_7.png","image_animation_dog_win_8.png","image_animation_dog_win_9.png","image_animation_dog_win_10.png","image_animation_dog_win_11.png","image_animation_dog_win_12.png","image_animation_dog_win_13.png","image_animation_dog_win_14.png","image_animation_dog_win_15.png","image_animation_dog_win_16.png","image_animation_dog_win_17.png"]
             frameRate: 6
         }

         TexturePackerSprite {
             name: "doglose"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_lose_1.png","image_animation_dog_lose_2.png","image_animation_dog_lose_3.png","image_animation_dog_lose_4.png","image_animation_dog_lose_5.png","image_animation_dog_lose_6.png","image_animation_dog_lose_7.png","image_animation_dog_lose_8.png"]
             x:10
             frameRate: 6
         }

         TexturePackerSprite {
             id:dogsmile
             name: "dogsmile"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_smile_1.png","image_animation_dog_smile_2.png","image_animation_dog_smile_1.png","image_animation_dog_smile_2.png","image_animation_dog_smile_1.png","image_animation_dog_smile_2.png"]
             frameRate: 6
             to:{"dogseat":1}
         }

         TexturePackerSprite {
             name: "dogsmilehit"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_smile_1.png","image_animation_dog_smile_2.png","image_animation_dog_smile_1.png","image_animation_dog_smile_2.png","image_animation_dog_smile_1.png","image_animation_dog_smile_2.png"]
             frameRate: 6
             to:{"dogseathold":1}
         }

         TexturePackerSprite {
             name: "doginjure1"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_injure_1_1.png","image_animation_dog_injure_1_2.png","image_animation_dog_injure_1_3.png","image_animation_dog_injure_1_4.png","image_animation_dog_injure_1_5.png","image_animation_dog_injure_1_6.png"]
             frameRate: 6
             to:{"dogseat":1}
         }

         TexturePackerSprite {
             name: "doginjure3"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_injure_3_1.png","image_animation_dog_injure_3_2.png","image_animation_dog_injure_3_3.png","image_animation_dog_injure_3_4.png","image_a  MouseArea{
      id:dogact
      x:430
      y:0
      width: 50
      height: 50
      onPressed: {
          dogTurn()
      }
  }nimation_dog_injure_3_5.png","image_animation_dog_injure_3_6.png","image_animation_dog_injure_3_7.png","image_animation_dog_injure_3_8.png","image_animation_dog_injure_3_9.png","image_animation_dog_injure_3_10.png","image_animation_dog_injure_3_11.png","image_animation_dog_injure_3_12.png","image_animation_dog_injure_3_13.png"]
             frameRate: 6
         }

         TexturePackerSprite {
             name: "doginjure4"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_dog_injure_4_1.png","image_animation_dog_injure_4_2.png","image_animation_dog_injure_4_3.png","image_animation_dog_injure_4_4.png","image_animation_dog_injure_4_5.png","image_animation_dog_injure_4_6.png","image_animation_dog_injure_4_7.png","image_animation_dog_injure_4_8.png","image_animation_dog_injure_4_9.png","image_animation_dog_injure_4_10.png","image_animation_dog_injure_4_11.png","image_animation_dog_injure_4_12.png"]
             x:10
             frameRate: 6
         }

         MouseArea {
             anchors.fill: dogSprite
             onPressed: {
                 timeslider.visible=false
                 initTime=0
                 timer.start()
                 clockOff()
                 preSliderOn()
                 turn.visible=false
             }
             onReleased: {
                 timer.stop()
                 preSliderOff()
                 if(isPower==1){
                     entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Lover.qml"), {"start" : Qt.point(353,220),"time":initTime,"who":"dog","isWitch":1,"width":30,"height":23})
                     isPower=0
                 }else{
                     entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Lover.qml"), {"start" : Qt.point(360,220),"time":initTime,"who":"dog","isWitch":1,"width":25,"height":18})
                 }


                 dogSprite.jumpTo("dogthrow")
                 dogSprite.enabled=false
//                 catSprite.enabled=true
             }
         }
  }

  TexturePackerSpriteSequence {
         id: bgSprite
         x:380
         y:190
         z:1
         visible: false
         TexturePackerSprite {
             name: "dogclock"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_clock_1.png","image_animation_clock_2.png","image_animation_clock_3.png","image_animation_clock_4.png","image_animation_clock_5.png","image_animation_clock_6.png","image_animation_clock_7.png","image_animation_clock_8.png","image_animation_clock_9.png","image_animation_clock_10.png","image_animation_clock_11.png","image_animation_clock_12.png","image_animation_clock_13.png","image_animation_clock_14.png","image_animation_clock_15.png","image_animation_clock_16.png","image_animation_clock_17.png","image_animation_clock_18.png","image_animation_clock_19.png","image_animation_clock_20.png"]
             frameRate: 6
         }
         TexturePackerSprite {
             name: "catclock"
             source: "../../assets/img/catVsDog.json"
             frameNames: ["image_animation_clock_1.png","image_animation_clock_2.png","image_animation_clock_3.png","image_animation_clock_4.png","image_animation_clock_5.png","image_animation_clock_6.png","image_animation_clock_7.png","image_animation_clock_8.png","image_animation_clock_9.png","image_animation_clock_10.png","image_animation_clock_11.png","image_animation_clock_12.png","image_animation_clock_13.png","image_animation_clock_14.png","image_animation_clock_15.png","image_animation_clock_16.png","image_animation_clock_17.png","image_animation_clock_18.png","image_animation_clock_19.png","image_animation_clock_20.png"]
             x:-363
             y:-26
             frameRate: 6
         }
  }

  TexturePackerAnimatedSprite {
      id: garbage
      source: "../../assets/img/catVsDog.json"
      frameNames: ["image_thung_rac.png"]
      width:150
      height:60
      x:45
      y:225
      z:0
  }

  TexturePackerAnimatedSprite {
      id: dish
      source: "../../assets/img/catVsDog.json"
      frameNames: ["image_chau_xuong.png"]
      width:50
      height:35
      x:355
      y:250
      z:0
  }

  TexturePackerAnimatedSprite {
      id: blood
      source: "../../assets/img/catVsDog.json"
      frameNames: ["bg_blood.png"]
      width:460
      height:20
      x:10
      y:25
      z:1
  }

  TexturePackerAnimatedSprite {
      id: bloodcat
      source: "../../assets/img/catVsDog.json"
      frameNames: ["bg_blood_cat.png"]
      width:190.9
      height:12.8
      x:12.2
      y:28.5
      z:1
  }

  TexturePackerAnimatedSprite {
      id: blooddog
      source: "../../assets/img/catVsDog.json"
      frameNames: ["bg_blood_dog.png"]
      width:192
      height:12.8
      x:275
      y:28.5
      z:1
  }

  Row{
         anchors.top: blood.bottom
         anchors.topMargin: 5
         anchors.left: parent.left
         anchors.leftMargin: 50
         spacing: 10
             PlayButton{
                 id:incatBlood
                 label.source: "../../assets/img/button_function_blood.png"
                 color: "transparent"
                 width: 20
                 height: 20
                 onClicked: {
                     opacity = 0
                     enabled = false
                     addBlood()
                 }
             }

             PlayButton{
                 id:incatPower
                 label.source: "../../assets/img/button_function_power.png"
                 color: "transparent"
                 width: 20
                 height: 20
                 onClicked: {
                     opacity = 0
                     enabled = false
                     isPower=1
                 }

             }

             PlayButton{
                 id:incatDouble
                 label.source: "../../assets/img/button_function_double.png"
                 color: "transparent"
                 width: 20
                 height: 20
                 onClicked: {
                     opacity = 0
                     enabled = false
                     isDouble=1
                 }
             }

             PlayButton{
                 id:incatBomb
                 label.source: "../../assets/img/button_function_bomb.png"
                 color: "transparent"
                 width: 20
                 height: 20
                 onClicked: {
                     opacity = 0
                     enabled = false
                     isBomb=1
                 }
             }
     }

     Row{
         anchors.top: blood.bottom
         anchors.topMargin: 5
         anchors.right: parent.right
         anchors.rightMargin: 50
         spacing: 10
         PlayButton{
             id:indogBomb
             label.source: "../../assets/img/button_function_bomb.png"
             color: "transparent"
             width: 20
             height: 20
             onClicked: {
                 opacity = 0
                 enabled = false
                 isBomb=1
             }
         }
         PlayButton{
             id:indogDouble
             label.source: "../../assets/img/button_function_double.png"
             color: "transparent"
             width: 20
             height: 20
             onClicked: {
                 opacity = 0
                 enabled = false
                 isDouble=1
             }
         }
         PlayButton{
             id:indogPower
             label.source: "../../assets/img/button_function_power.png"
             color: "transparent"
             width: 20
             height: 20
             onClicked: {
                 opacity = 0
                 enabled = false
                 isPower=1
             }
         }
         PlayButton{
             id:indogBlood
             label.source: "../../assets/img/button_function_blood.png"
             color: "transparent"
             width: 20
             height: 20
             onClicked: {
                 opacity = 0
                 enabled = false
                 addBlood()
             }
         }
     }

  TexturePackerAnimatedSprite {
      id: bgwind
      source: "../../assets/img/catVsDog.json"
      frameNames: ["bg_wind.png"]
      width:95
      height:40
      x:190
      y:45
      z:1
  }

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

  TexturePackerAnimatedSprite {
      id: background
      source: "../../assets/img/catVsDog.json"
      frameNames: ["bg_loading.png"]
      anchors.fill:parent
      z:-1
  }


  Image {
      x:isTurn?60:400
      y:isTurn?165:180
      id: turn
      source: "../../assets/img/image_turn.png"
      z:1
      opacity: 1
      visible: false
      //Through the change of transparency to achieve the effect of picture flashing
      SequentialAnimation on opacity{
          NumberAnimation{
              to:0.1
              duration: 1000
          }

          NumberAnimation{
              to:1
              duration: 1000
          }

          loops:Animation.Infinite

      }
  }

  Image  {
      id: imgwindleft
      x:195
      y:50
      z:1
      visible: false
      source: "../../assets/img/image_wind_left.png"
      opacity: 1
      SequentialAnimation on opacity{
          NumberAnimation{
              to:0.1
              duration: 1000
          }

          NumberAnimation{
              to:1
              duration: 1000
          }

          loops:Animation.Infinite

      }
  }

  Image  {
      id: imgwindright
      x:270
      y:50
      z:1
      visible: false
      source: "../../assets/img/image_wind_right.png"
      opacity: 1
      SequentialAnimation on opacity{
          NumberAnimation{
              to:0.1
              duration: 1000
          }

          NumberAnimation{
              to:1
              duration: 1000
          }

          loops:Animation.Infinite

      }
  }

  Image  {
      id: timeslider
      x:isTurn?43:405
      y:isTurn?173:196
      z:1
      width: 40
      height: 6
      visible: false
      source: "../../assets/img/image_slider_speed.png"


      NumberAnimation{
          id:timesliderwidth
          target: timeslider
          properties:"width"
          from:40
          to:0
          duration: 4000
//          easing: {type:Easing.OutBack}
      }
  }

  Image {
      id: bgpreslider
      x:isTurn?40:390
      y:isTurn?173:196
      source: "../../assets/img/image_slider_speed_bg.png"
      z:1
      width: 50
      height: 6
      visible: false
  }

  Image {
      id: preslider
      x:isTurn?40:390
      y:isTurn?173:196
      z:1
      width: 0
      height: 6
      visible: false
      source: "../../assets/img/image_slider_speed.png"


      NumberAnimation{
          id:presliderwidth
          target: preslider
          properties:"width"
          from:0
          to:50
          duration: 2500
//          easing: {type:Easing.OutBack}
      }
  }

  TexturePackerAnimatedSprite {
      id: windleft
      x:208
      y:70
      width: 40
      height: 8
      z:1
      visible: false
      source: "../../assets/img/catVsDog.json"
      frameNames: ["bg_wind_left.png"]
  }

  TexturePackerAnimatedSprite {
      id: windright
      x:228
      y:70
      width: 40
      height: 8
      z:1
      visible: false
      source: "../../assets/img/catVsDog.json"
      frameNames: ["bg_wind_right.png"]
  }

  PhysicsWorld {
//      debugDrawVisible: true
      id:physicsworld
      updatesPerSecondForPhysics:0
      gravity.y:9.8
      gravity.x:wind
  }
  Wall{
        x:230
        y:160
        z:1

        boxCollider.width: 20
        boxCollider.height: 130

        onWallHitted: wallHit()
    }

    Wall{
        y:280

        boxCollider.width: 500
        boxCollider.height: 3

        onWallHitted: wallHit()
    }

    Wall{
        x:0
        y:0

        boxCollider.width: 5
        boxCollider.height: 500

        onWallHitted: wallHit()
    }
    Wall{
        x:475
        y:0

        boxCollider.width: 5
        boxCollider.height: 500

        onWallHitted: wallHit()
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
            countdown.stop()
            wind=0
        }
    }

    SoundEffect{
        id:catSmiling
        source: "../../assets/snd/cat_smile.wav"
        autoPlay: false
    }

    SoundEffect{
        id:dogSmiling
        source: "../../assets/snd/dog_smile.wav"
    }

    SoundEffect{
        id:catCry
        source: "../../assets/snd/cat_injure_1.wav"
    }

    SoundEffect{
        id:dogCry
        source: "../../assets/snd/dog_injure_1.wav"
    }

    SoundEffect{
        id:throwLover
        source: "../../assets/snd/throw.wav"
    }

}
