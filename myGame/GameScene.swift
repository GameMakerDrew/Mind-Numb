//
//  GameScene.swift
//  myGame
//
//  Created by Collins, Andrew Douglas on 12/13/17.
//  Copyright © 2017 Collins, Andrew Douglas. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    var bgNumber:CGFloat = 0
    var bgColor:UIColor = UIColor.init(red: 0.38, green: 0, blue: 0.28, alpha: 1)
    var bgNumberBlue:CGFloat = 0
    var firstPoint:CGPoint = CGPoint(x: 0, y: 0)
    var enemy1 = SKSpriteNode()
    var stars:SKEmitterNode!
    var starExplosion:SKEmitterNode!
    var ufoDust:SKEmitterNode!
    let powerup:SKSpriteNode = SKSpriteNode(imageNamed: "powerup")
    let player:SKSpriteNode = SKSpriteNode(imageNamed: "ufo")
    var fingerOnPlayer:Bool!
    var score:Int = 0
    var scoreLabel:SKLabelNode = SKLabelNode()
    
        override init(size: CGSize) {
        super.init(size: size)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        
        scene!.backgroundColor = bgColor
        
        starExplosion = SKEmitterNode(fileNamed: "starSplosion")
        ufoDust = SKEmitterNode(fileNamed: "dust")
        stars = SKEmitterNode(fileNamed: "snow")
        enemy1 = self.childNode(withName: "enemy1") as! SKSpriteNode
        
        self.addChild(ufoDust)
        self.addChild(stars)
       
        ufoDust.zPosition = -1
        stars.zPosition = -2
        stars.position = CGPoint(x: 0, y: 0)
    
        scoreLabel.position = CGPoint(x: 0, y: 0)
        scoreLabel.fontName = "Optima-ExtraBlack"
        scoreLabel.fontColor = .white
        scoreLabel.fontSize = 100
        scoreLabel.text = "\(score)"
        self.addChild(scoreLabel)
       
        let border:SKPhysicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsWorld.contactDelegate = self
        self.physicsBody = border
        self.physicsBody?.restitution = 1
        self.physicsBody?.friction = 0
        self.physicsBody?.categoryBitMask = 10
        
        powerup.name = "powerup"
        powerup.physicsBody = SKPhysicsBody(circleOfRadius: powerup.frame.height/2)
        powerup.physicsBody?.affectedByGravity = false
        powerup.physicsBody?.allowsRotation = false
        powerup.physicsBody?.isDynamic = true
        powerup.physicsBody?.pinned = true
        powerup.position = CGPoint(x: 200, y: 100)
        powerup.physicsBody?.categoryBitMask =  1
        powerup.physicsBody?.collisionBitMask = 2
        powerup.physicsBody?.contactTestBitMask = 2
        self.addChild(powerup)
        
        enemy1.physicsBody?.affectedByGravity = false
        enemy1.physicsBody?.pinned = false
        enemy1.physicsBody?.friction = 0
        enemy1.physicsBody?.restitution = 1
        enemy1.physicsBody?.linearDamping = 0
        enemy1.physicsBody?.angularDamping = 0
        enemy1.physicsBody?.isDynamic = true
        enemy1.physicsBody?.isResting = false
        enemy1.physicsBody?.allowsRotation = false
        enemy1.physicsBody?.categoryBitMask = 3
        enemy1.physicsBody?.collisionBitMask = 10
        enemy1.physicsBody?.contactTestBitMask = 2
        enemy1.physicsBody?.applyImpulse(CGVector(dx: 60, dy: 90))
        
        player.name = "player"
        player.position = firstPoint
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.frame.height/2)
        player.color = SKColor(displayP3Red: 1, green: 0, blue: 0, alpha: 1)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.pinned = false
        player.physicsBody?.friction = 0
        player.physicsBody?.restitution = 1
        player.physicsBody?.linearDamping = 0
        player.physicsBody?.angularDamping = 0
        player.physicsBody?.isDynamic = false
        player.physicsBody?.isResting = false
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = 2
        player.physicsBody?.collisionBitMask = 1
        player.physicsBody?.contactTestBitMask = 1
        self.addChild(player)
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        //print("contact")
        let body1 = contact.bodyA.node
        let body2 = contact.bodyB.node
        
        if body1?.name == "powerup" && body2?.name == "player" {
            
            body1?.removeFromParent()
            addScore()
        }else if body2?.name == "powerup" && body1?.name == "player" {
            
            
        }
        
        if body1?.name == "enemy1" && body2?.name == "player" {
            print("contact")
            newGame()
           
        
        }else if body2?.name == "enemy1" && body1?.name == "player" {
        print("conact2")
            
        }
        
    }
    
    func newGame(){
        
        if let view = self.view {
            if let scene = GameOver(fileNamed: "GameOver") {
                
                scene.scaleMode = .aspectFill
                scene.scoreInt = score
                scene.backgroundColor = bgColor
                view.presentScene(scene)
                
            }
        }
        
        
    }
    
    func addScore(){
        bgNumber += 0.01
        if score < 38{
        scene?.backgroundColor = UIColor.init(red: 0.38 - bgNumber, green: 0, blue: 0.28, alpha: 1)
        }else{
        bgNumberBlue += 0.01
        scene?.backgroundColor = UIColor.init(red: 0 , green: 0, blue: 0.28 - bgNumberBlue, alpha: 1)
        }
        
        bgColor = (scene?.backgroundColor)!
        
        
        
        score += 1
        scoreLabel.text = "\(score)"
        
       // let starSpot:CGPoint = CGPoint(x: powerup.position.x, y: powerup.position.y)
        
        
       // let explosion:SKEmitterNode = SKEmitterNode(fileNamed: "starSplosion")!
       // explosion.position = starSpot
       // self.addChild(explosion)
       // self.run(SKAction.wait(forDuration: 0.5), completion: { explosion.removeFromParent() })
       
  
        let negPos:UInt32 = arc4random_uniform(2)
        let negPos1:UInt32 = arc4random_uniform(2)
        var x:Int = Int(arc4random_uniform(UInt32(self.frame.maxX)))
        var y:Int = Int(arc4random_uniform(UInt32(self.frame.maxY)))
        
        var veloctityChange:Int = 0
        if negPos == 0 {
            x = x * -1
        }
        if negPos1 == 0 {
            y = y * -1
        }
        powerup.position = CGPoint(x: Int(x), y:Int(y))
        self.addChild(powerup)
        
        let dx:CGFloat = (enemy1.physicsBody?.velocity.dx)!
        let dy:CGFloat = (enemy1.physicsBody?.velocity.dy)!
        
        if score < 20{
            veloctityChange = 5
        }else if score > 20 && score < 50 {
            veloctityChange = 4
        }else if score > 50 && score < 70 {
            veloctityChange = 3
        }else if score > 100{
            veloctityChange = 0
        }
        
        
        
        
        
        
        if dx < 0 && dy < 0 {
            enemy1.physicsBody?.applyImpulse(CGVector(dx: -veloctityChange, dy: -veloctityChange))
        }else if dx > 0 && dy > 0 {
            enemy1.physicsBody?.applyImpulse(CGVector(dx: veloctityChange, dy: veloctityChange))
        }else if dx < 0 && dy > 0 {
            enemy1.physicsBody?.applyImpulse(CGVector(dx: -veloctityChange, dy: veloctityChange))
        }else if dx > 0 && dy < 0 {
            enemy1.physicsBody?.applyImpulse(CGVector(dx: veloctityChange, dy: -veloctityChange))
        }
   
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
 
        for touch in touches {
            let location = touch.location(in: self)
            let body:SKPhysicsBody? = self.physicsWorld.body(at: location)
            if body?.node?.name == "player" {
                print("touched")
                fingerOnPlayer = true
            }
    
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if fingerOnPlayer == true {
            let location = touch.location(in: self)
            player.run(SKAction.move(to: location, duration: 0))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            fingerOnPlayer = false
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        ufoDust.position = CGPoint(x: player.position.x, y: player.position.y)
        ufoDust.emissionAngle += 3
        
    }
}
