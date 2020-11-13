//
//  GameOver.swift
//  myGame
//
//  Created by Collins, Andrew Douglas on 12/18/17.
//  Copyright © 2017 Collins, Andrew Douglas. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit

class GameOver: SKScene{
    
    var scoreLabel:SKLabelNode = SKLabelNode()
    var scoreInt:Int = 0
    let snow:SKEmitterNode = SKEmitterNode(fileNamed: "snow")!
    let ufo:SKEmitterNode = SKEmitterNode(fileNamed: "dust")!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        score()
    }
    
    
    
    
    func score(){
        
        if let view = self.view {
            if let scene = Menu(fileNamed: "Menu") {
                
                scene.scaleMode = .aspectFill
                 let transition = SKTransition.doorsOpenVertical(withDuration: 1)
                view.presentScene(scene, transition: transition)
                
            }
        }
    }
    
    
    override func didMove(to view: SKView) {
        
        scoreLabel.position = CGPoint(x: 0, y: -70)
        scoreLabel.fontName = "Optima-ExtraBlack"
        scoreLabel.fontSize = 150
        scoreLabel.fontColor = .green
        scoreLabel.text = "\(scoreInt)"
        ufo.position = CGPoint(x: 64, y: 518)
        ufo.zPosition = -2
        self.addChild(ufo)
        self.addChild(snow)
        self.addChild(scoreLabel)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        ufo.emissionAngle += 3
    }
    
}
