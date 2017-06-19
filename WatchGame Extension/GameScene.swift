//
//  GameScene.swift
//  WatchGame Extension
//
//  Created by supransh on 4/1/17.
//  Copyright © 2017 jayanti supransh murty. All rights reserved.
//

import SpriteKit
import WatchKit

class GameScene: SKScene, WKCrownDelegate {
    
    var paddle_up:SKSpriteNode = SKSpriteNode()
    var paddle_down:SKSpriteNode = SKSpriteNode()
    var pong:SKSpriteNode = SKSpriteNode()
    var label:SKLabelNode = SKLabelNode()
    var score = [Int]()
    //var count: Int = Int()
    var reduceDifficulty = 0.0
    var randomizer = -1
    
    var my_label = SKLabelNode()
    var enemy_label = SKLabelNode()
    
        override func sceneDidLoad() {
            
        self.physicsWorld.speed = 0.5
            
            
        my_label = self.childNode(withName : "my_score") as! SKLabelNode
        enemy_label = self.childNode(withName: "enemy_score") as! SKLabelNode
        label = self.childNode(withName : "go") as! SKLabelNode
    
        
        for node in self.children
        {
            if (node.name == "paddle_up")
            {
                if let paddle :SKSpriteNode = node as? SKSpriteNode{
                    paddle_up = paddle
            }
            }
            
            if (node.name == "paddle_down")
            {
                if let paddle :SKSpriteNode = node as? SKSpriteNode{
                paddle_down = paddle
            }
                }
            
            if (node.name == "label") {
                
                if let someLabel :SKLabelNode = node as? SKLabelNode{
                    label = someLabel
                        
                }
            }
            if (node.name == "pong") {
                
                if let someball :SKSpriteNode = node as? SKSpriteNode{
                pong = someball
                    
                }
            }}
        
        
        //let crownSequencer = WKExtension.shared().rootInterfaceController!.crownSequencer
        pong.position = CGPoint(x: 0 , y: 0)
        pong.physicsBody?.pinned = true
        pong.physicsBody?.restitution = 1
        //pong.physicsBody?.applyImpulse(CGVector(dx: 1 , dy: 1 ))


        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        border.mass = CGFloat(92233720)
        self.physicsBody = border
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.label.text = "GO!"
                self.label.fontColor = SKColor.green
            
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.label.text = " "
                self.pong.physicsBody?.pinned = false
                self.pong.physicsBody?.velocity = CGVector(dx: 151*self.randomizer , dy:200)
                self.randomizer = 1
            }
            self.startGame()
            
    }
    
    func startGame(){
        score = [0,0]
        self.my_label.text = "\(score[0])"
        self.enemy_label.text = "\(score[1])"

    }
    
    /*func didBeginContact(contact: SKPhysicsContact){
        
        
        if(contact.bodyA.node?.name == "pong" && (contact.bodyB.node?.name) == "paddle_down"){
            print("con")
            self.reduceDifficulty += 1}
        
            }
    */

    
    func addScore( playerWon: SKSpriteNode )
    {
        
        //pong.physicsBody?.pinned = true
       
        self.reduceDifficulty = 0
        self.pong.position = CGPoint(x: 20 , y: -40)
        self.pong.physicsBody?.velocity = CGVector(dx: 0 , dy:0)
        if playerWon == self.paddle_up{
            self.score[1] += 1
            self.pong.physicsBody?.velocity = CGVector(dx: 151 , dy: 200 )
               // self.pong.physicsBody?.pinned = false
                //self.paddle_up.physicsBody?.pinned = false
            
            
                    }
        else if playerWon == self.paddle_down{
            self.score[0] += 1
                self.pong.physicsBody?.velocity = CGVector(dx: 151 , dy: 200 )
        //        self.pong.physicsBody?.pinned = false
                //self.paddle_up.physicsBody?.pinned = false

        }
        
        self.my_label.text = "\(self.score[0])"
        self.enemy_label.text = "\(self.score[1])"
        
        //self.count = Int(arc4random_uniform(100)+1)
        

        }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        paddle_up.run(SKAction.moveTo(x: pong.position.x, duration: 0.1+0.05*self.reduceDifficulty))
        
        if(paddle_up.position.x < -56){
            paddle_up.run(SKAction.moveTo(x: -55, duration: 0.24))
        }
        if(paddle_up.position.x > 56){
            paddle_up.run(SKAction.moveTo(x: 55, duration: 0.24))
        }
        
        
        if pong.position.y <= paddle_down.position.y{
            addScore(playerWon : paddle_up)
        }
        else if pong.position.y >= paddle_up.position.y{
            addScore(playerWon: paddle_down)
 
        }
        
        if (pong.physicsBody?.velocity.dy == 0)
        {
            pong.position = CGPoint(x: 0, y: 0)
            pong.physicsBody?.velocity = CGVector(dx: 151*self.randomizer , dy: 200)
        }
        if(pong.physicsBody?.velocity.dx == 0)
        {
            pong.position = CGPoint(x: 0 , y: 0)
            pong.physicsBody?.velocity = CGVector(dx: 151*self.randomizer , dy: 200)
        }
        
        self.reduceDifficulty += 0.005
        var count = 1
        count += 1
        if (count%2 == 0){
        self.randomizer = -1
        }
        else{
            self.randomizer = 1
        }
        
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?,
                        rotationalDelta: Double)
    {
        
            movePaddle(who: paddle_down , amount:CGFloat(100*rotationalDelta))
        
        }
    }
    

    func movePaddle(who: SKSpriteNode , amount: CGFloat)
    {
        
        let move: SKAction = SKAction.moveBy(x: amount, y: 0, duration: 1)
        move.timingMode = .easeOut
        who.run(move)
        
    }
    


