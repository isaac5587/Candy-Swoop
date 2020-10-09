//
//  GameViewController.swift
//  Candy Snatch
//
//  Created by Trill Isaac on 6/11/19.
//  Copyright © 2019 Isaac Ansumana. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    var backingAudio = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         let url:NSURL = Bundle.main.url(forResource: "gamePlaySong", withExtension: "mp3")! as NSURL
         
         do {
         backingAudio = try AVAudioPlayer(contentsOf: url as URL, fileTypeHint: nil)
         } catch _{
         return
         }
         
         backingAudio.numberOfLoops = 1
         backingAudio.play()
         
         */
        if let view = self.view as! SKView? {
            
            let scene = MainMenuScene(size: CGSize(width: 1536, height: 2048))       //configure the view
            // if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
        }
        
        //  view.ignoresSiblingOrder = true
        
        //  view.showsFPS = true
        //   view.showsNodeCount = true
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
