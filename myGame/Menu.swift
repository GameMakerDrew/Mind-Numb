//
//  Menu.swift
//  myGame
//
//  Created by Collins, Andrew Douglas on 12/18/17.
//  Copyright © 2017 Collins, Andrew Douglas. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit

class Menu: SKScene{
    
    let stars:SKEmitterNode = SKEmitterNode(fileNamed: "snow")!
    let label:SKLabelNode = SKLabelNode(text: "Touch Anywhere to Begin!")
    let labelAndrew:SKLabelNode = SKLabelNode(text: "Made by: Andrew Collins")
    let ufoDust:SKEmitterNode = SKEmitterNode(fileNamed: "dust")!
    var firstPoint:CGPoint = CGPoint(x: 0, y: 0)
    
    override func didMove(to view: SKView) {
        
        
        
        label.position = CGPoint(x: 0, y: -500)
        label.fontName = "Optima-ExtraBlack"
        label.fontSize = 50
        label.fontColor = .white
        
        labelAndrew.position = CGPoint(x: 0, y: -580)
        labelAndrew.fontName = "Optima-ExtraBlack"
        labelAndrew.fontSize = 30
        labelAndrew.fontColor = .white
        
        ufoDust.zPosition = -1
        ufoDust.position = CGPoint(x: 0, y: 0)
        self.addChild(stars)
        self.addChild(label)
        self.addChild(ufoDust)
        self.addChild(labelAndrew)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            firstPoint = touch.location(in: self)
        }
        
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene{
                
                scene.scaleMode = .aspectFill
                scene.firstPoint = firstPoint
                scene.fingerOnPlayer = true
               
                view!.presentScene(scene)

        }
    }
  
    override func update(_ currentTime: TimeInterval) {
        ufoDust.emissionAngle += 3
    }
}
