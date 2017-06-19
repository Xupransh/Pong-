//
//  InterfaceController.swift
//  WatchGame Extension
//
//  Created by supransh on 4/1/17.
//  Copyright © 2017 jayanti supransh murty. All rights reserved.
//

import WatchKit
import Foundation





class InterfaceController: WKInterfaceController, WKCrownDelegate {
    
    @IBOutlet var skInterface: WKInterfaceSKScene!

    
    var gameScene: GameScene!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
       
        // Configure interface objects here.
        
        // Load the SKScene from 'GameScene.sks'
        if let scene = GameScene(fileNamed: "GameScene") {
            
            gameScene = scene
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            self.skInterface.presentScene(scene)
            
            // Use a value that will maintain a consistent frame rate
            self.skInterface.preferredFramesPerSecond = 27
            
            crownSequencer.delegate = self.gameScene
            crownSequencer.focus()
            
            
            
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func handleTap(_ sender: Any) {
        gameScene.label.text = " "
        //print("Tap")
    }
    
    @IBOutlet var reset: WKLongPressGestureRecognizer!
    
    
}
