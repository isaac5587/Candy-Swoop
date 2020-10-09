//
//  MainMenuScene.swift
//  Candy Snatch
//
//  Created by Trill Isaac on 6/11/19.
//  Copyright © 2019 Isaac Ansumana. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene{
    
   //sound when you click the buttons
    let clickSound = SKAction.playSoundFileNamed("clickSound", waitForCompletion: false)
    
   
    //menu background
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "menuBackground")
        background.size = self.size
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        //game logo on main menu
        let logo = SKSpriteNode(imageNamed: "gameLogo")
        logo.zPosition = 1
        logo.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.65)
        self.addChild(logo)
        
        //begin button text
        let beginLabel = SKLabelNode(fontNamed: "Goldfather")
        beginLabel.text = "Begin"
        beginLabel.fontColor = SKColor.white
        beginLabel.fontSize = 150
        beginLabel.zPosition = 2
        beginLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        beginLabel.name = "startButton"
        self.addChild(beginLabel)
        
        
        //begin button shape underlay
        let button = SKSpriteNode(imageNamed: "button")
        button.zPosition = 1
        button.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.22)
        self.addChild(button)
        button.name = "startButton"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self) // location touched
            let tappedNode = atPoint(pointOfTouch) // putting touch location to game objects
            let tappedNodeName = tappedNode.name
            
            if tappedNodeName == "startButton"{ // checking if startbutton is touched
                
                self.run(clickSound) // playing clicksound
                
                let sceneToMoveTo = GameScene(size: self.size)// moves to gameplay scene
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.2) //scene fade
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition) // play screen
            }
        }
    }
    
}
