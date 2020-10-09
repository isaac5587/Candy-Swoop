//
//  GameScene.swift
//  Candy Snatch
//
//  Created by Trill Isaac on 6/11/19.
//  Copyright © 2019 Isaac Ansumana. All rights reserved.
//

import SpriteKit //brings spritekit from library

var scoreNumber = 0 // variable for score

class GameScene: SKScene {
    
   
    let scoreLabel = SKLabelNode(fontNamed: "Goldfather") // font for score label 
    
    let playGameOverSoundEffect = SKAction.playSoundFileNamed("gameOverSound", waitForCompletion: false)  // sets the sound variable equal to the file name
    
    let startLabel = SKLabelNode(fontNamed: "Goldfather")    // allows start label to use the font
   
    enum gameState{     // enumeration for the three different game states before,during, and after
        
        case preGame  //Menu Screen
        case inGame   // Game Screen
        case afterGame // Game Over Scene
    }
    
    var currentgameState = gameState.preGame   // this is what happens in preGame state
    
    //Plays sound effect when candy is tapped with the file
    let playCorrectSoundEffect = SKAction.playSoundFileNamed("candySound", waitForCompletion: false)
    
    let gameArea: CGRect // making game area the whole iphone screen
    
    override init(size: CGSize) {
        //screen boundaries/ game area
        let maxAspectRatio: CGFloat = 16.0/9.0   // gamePlay ratio
        let playableWidth = size.height / maxAspectRatio
        let gameAreaMargin = (size.width - playableWidth)/2 //spawns candy so that it appears on every device screen boundaries
        gameArea = CGRect(x: gameAreaMargin, y: 0, width: playableWidth, height: size.height)
        //Making the variable for gamePlay
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {  //in case of an error
        fatalError("init(coder) has not been implemented")
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)  // functions spawn the astroheads at different locations
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min // gives the astroheads a random location
    }
    
    override func didMove(to view: SKView) {
      
        scoreNumber = 0  // score variable
        
        let background = SKSpriteNode(imageNamed: "background")  // creating background
        background.size = self.size  // setting the background size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2) //proportional size for all devices        
        self.addChild(background) // adds the image into the 
        
        let disc = SKSpriteNode(imageNamed: "candy2")
        disc.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        disc.zPosition = 2
        disc.name = "discObject"
        self.addChild(disc)
        
        scoreLabel.fontSize = 250 //font label size
        scoreLabel.text = "0"   // starting label text
        scoreLabel.fontColor = SKColor.cyan  //font color
        scoreLabel.zPosition = 1   // depth position
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.85) //position to fit any scree
        self.addChild(scoreLabel)  //adds the label
        
        let moveOnToScreenAction = SKAction.moveTo(y: self.size.height * 0.9, duration: 0.9)
        scoreLabel.run(moveOnToScreenAction) // moves the label to the screen
        
    
        startLabel.text = "Tap the candy before it disappears"  //directions label
        startLabel.fontSize = 50
        startLabel.fontColor = SKColor.magenta
        startLabel.zPosition = 1
        startLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        startLabel.alpha = 0
        self.addChild(startLabel)
        
          let fadeInAction = SKAction.fadeIn(withDuration: 0.05) // directions disappear
          startLabel.run(fadeInAction)
        
    }
    
    func spawnNewDisc(){  //spawning candy
        var randomImageNumber = arc4random()%20 //random number
        randomImageNumber += 1 //keeps on spawning
        
        let disc = SKSpriteNode(imageNamed: "candy\(randomImageNumber)") //random image number
        disc.zPosition = 2
        disc.name = "discObject"  //name of the candy
        
        
        // for the candy to always stay on-screen
        let randomX = random(min: gameArea.minX + disc.size.width/2,
                             max: gameArea.maxX - disc.size.width/2)
        
        let randomY = random(min: gameArea.minY + disc.size.height/2,
                             max: gameArea.maxY - disc.size.height/2)
        
        disc.position = CGPoint(x: randomX, y: randomY) // random cordinate for candy position
        self.addChild(disc)
        
        disc.run(SKAction.sequence([SKAction.scale(by: 0, duration: 3), playGameOverSoundEffect,
            SKAction.run(runGameOver)])) //shrinks candy

    }
    
    //when the game begins
    func startGame(){
        currentgameState = gameState.inGame  //gamestate
        
        let fadeOutAction = SKAction.fadeIn(withDuration: 0.5)
        let deleteAction = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([fadeOutAction, deleteAction])
        startLabel.run(deleteSequence)
    }
    
    // function for the gameover scene
    func runGameOver(){
        
        currentgameState = gameState.afterGame
        
        let sceneToMoveTo = GameOverScene(size: self.size) // moves to gameOver scene
        sceneToMoveTo.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fade(withDuration: 0.2)
        self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentgameState == gameState.preGame{
            startGame()
        }
        
        for touch: AnyObject in touches{  //loop for touches
            
            let positionOfTouch = touch.location(in:self)    
            let tappedNode = atPoint(positionOfTouch)
            let nameOfTappedNode = tappedNode.name
            
            if nameOfTappedNode == "discObject"{
               
                tappedNode.name = ""
                
                tappedNode.removeAllActions()
                
                tappedNode.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1),SKAction.removeFromParent()]))
                
                self.run(playCorrectSoundEffect) //plays sound effect for candy
                
                spawnNewDisc() // After candy is touched remove candy and spawn new candy at a new location
                
                scoreNumber += 1 //adds score
                scoreLabel.text = "\(scoreNumber)" //changes score label
            
               
                
                // creating the levels of the games
                if scoreNumber == 10 || scoreNumber == 50 || scoreNumber == 120 || scoreNumber == 200 || scoreNumber == 300 || scoreNumber == 500 || scoreNumber == 1000{
                    spawnNewDisc()
                }
            }
        }
    }

}
