/* Author: Group04(zhouyifan,zhuhongyun,zhangxinru)
 * Date: Final version:2020-07-08
 * Cat Vs Dog is a Classic strategy game, using turn system,
 * cat and dog throw each other to fight. The throwing process
 * needs to pay attention to the wind direction, wind speed,
 * grasp the investment strength, and the length of pressing
 * the mouse determines the power storage bar. Release the
 * mouse will throw the weapon to the other side.
 */

import Felgo 3.0
import QtQuick 2.0
import "scenes"
import "common"

GameWindow {
    id: window

    screenWidth: 960
    screenHeight: 640

    state: "start"
    activeScene: startScene

    // Font of the game
    FontLoader {
      id: font_nhayday
      source: "fonts/font_nhayday.ttf"
    }
    FontLoader {
      id: digital_7
      source: "fonts/digital-7.ttf"
    }

    StartScene{
        id:startScene
        onStartPressed: {
            enabled:false
            window.state = "menu"
        }
    }

    MenuScene{
        id:menuScene
        onGuidPressed: {
            enabled:false
            window.state = "instruction"

        }
        onGamePressed: {
            enabled:false
            window.state = "choosePattern"
        }
        opacity:0
    }

    InstructionScene{
        id:instructionScene
        onStartPressed: gameWindow.state = "choosePattern"
        opacity:0
    }

    ChoosePattern{
        id:choosePlayerScene
        opacity: 0
        onClassicPatternPressed: {
            gameWindow.state = "game1"
            gameScene1.initStates()
        }
        onFreePatternPressed: {
            gameWindow.state = "game2"
            gameScene2.initStates()

        }
        onExitPressed:{
            enabled:false
            gameWindow.state = "start"
        }
    }

    CatWinScene{
        id:catWinScene
        opacity: 0
        onReplay: {
            gameWindow.state = "choosePattern"
        }
    }

    DogWinScene{
        id:dogWinScene
        opacity: 0
        onReplay: {
             gameWindow.state = "choosePattern"
        }
    }

    GameScene1{
        id:gameScene1
        opacity:0
        onCatWinScene: gameWindow.state = "catWin"
        onDogWinScene: gameWindow.state = "dogWin"
        onBack: gameWindow.state = "start"
    }

    GameScene2 {
        id:gameScene2
        opacity: 0
        onCatWinScene: gameWindow.state = "catWin"
        onDogWinScene: gameWindow.state = "dogWin"
        onBack: gameWindow.state = "start"
    }

    states: [
        State {
            name: "start"
            PropertyChanges {
                target: startScene
                opacity:1
            }
            PropertyChanges {
                target: window
                activeScene:startScene
            }
        },
        State {
            name: "menu"
            PropertyChanges {
                target: menuScene
                opacity:1
            }
            PropertyChanges {
                target: window
                activeScene:menuScene
            }
        },
        State {
            name: "game1"
            PropertyChanges {
                target: gameScene1
                opacity: 1

            }
            PropertyChanges {
                target: window
                activeScene:gameScene1
            }
            PropertyChanges {
                target: startScene
                startButton.enabled: false
            }
        },
        State{
            name:"game2"
            PropertyChanges{
                target: gameScene2
                opacity: 1
            }
            PropertyChanges{
                target: gameWindow
                activeScene:gameScene2
            }
            PropertyChanges {
                target: startScene
                startButton.enabled: false
            }
        },
        State{
            name:"choosePattern"
            PropertyChanges{
                target: choosePlayerScene
                opacity: 1
            }
            PropertyChanges{
                target: gameWindow
                activeScene:choosePlayerScene
            }
        },
        State {
            name: "instruction"
            PropertyChanges {
                target: instructionScene
                opacity:1
            }
            PropertyChanges {
                target: gameWindow
                activeScene:instructionScene
            }
        },
        State{
            name:"catWin"
            PropertyChanges{
                target: catWinScene
                opacity: 1
            }
            PropertyChanges{
                target: gameWindow
                activeScene:catWinScene
            }
        },
        State{
            name:"dogWin"
            PropertyChanges{
                target: dogWinScene
                opacity: 1
            }
            PropertyChanges{
                target: gameWindow
                activeScene:dogWinScene
            }
        }
    ]

}
