//
//  GameOverScene.swift
//  Candy Snatch
//
//  Created by Trill Isaac on 6/11/19.
//  Copyright © 2019 Isaac Ansumana. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    
    let clickSound = SKAction.playSoundFileNamed("clickSound", waitForCompletion: false)
    
    
    //creating game over background
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "gameOverBackground")
        background.size = self.size
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
       
        //game over sign
        let gameOverLabel = SKLabelNode (fontNamed: "Goldfather")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 160
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.85)
        gameOverLabel.fontColor = SKColor.red
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
       
        //final score sign
        let finalScoreLabel = SKLabelNode(fontNamed: "GoldFather")
        finalScoreLabel.text = "Your Score: \(scoreNumber)"
        finalScoreLabel.fontSize = 120
        finalScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.75)
        finalScoreLabel.fontColor = SKColor.cyan
        finalScoreLabel.zPosition = 1
        self.addChild(finalScoreLabel)
        
        
        // saving the highest score
        let defaults = UserDefaults()
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        
        if scoreNumber > highScoreNumber{
            highScoreNumber = scoreNumber
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
        }
        
      
        //high score sign
        let highScoreLabel = SKLabelNode(fontNamed: "GoldFather")
        highScoreLabel.text = "Highest Score: \(highScoreNumber)"
        highScoreLabel.fontSize = 110
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.68)
        highScoreLabel.fontColor = SKColor.yellow
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
        
        
        // restart label
        let restartLabel = SKLabelNode(fontNamed: "GoldFather")
        restartLabel.text = "Try Again"
        restartLabel.fontSize = 120
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        restartLabel.fontColor = SKColor.green
        restartLabel.zPosition = 2
        restartLabel.name = "restartButton"
        self.addChild(restartLabel)
        
        // restart button
        let button2 = SKSpriteNode(imageNamed: "button2")
        button2.zPosition = 1
        button2.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.57)
        button2.name = "restartButton"
        self.addChild(button2)
        
        // exit label
        let exitLabel = SKLabelNode(fontNamed: "GoldFather")
        exitLabel.text = "Back to Main Menu"
        exitLabel.fontSize = 90
        exitLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.45)
        exitLabel.fontColor = SKColor.white
        exitLabel.zPosition = 2
        exitLabel.name = "exitButton"
        self.addChild(exitLabel)
        
        // exit button
        let button3 = SKSpriteNode(imageNamed: "button3")
        button3.zPosition = 1
        button3.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.46)
        button3.name = "exitButton"
        self.addChild(button3)
        
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self) // location touched
            let tappedNode = atPoint(pointOfTouch) // putting objects on touch location
            let tappedNodeName = tappedNode.name
            
            if tappedNodeName == "restartButton"{ //checking if restart button is touched
            
                self.run(clickSound) // play click sound
                
                
                let sceneToMoveTo = GameScene(size: self.size)  // go back to game scene
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.2)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
            }
            if tappedNodeName == "exitButton"{ // if exit button is tapped go back to main menu scene
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.2)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
            }
        }
    }

    
}
