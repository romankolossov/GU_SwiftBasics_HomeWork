//
//  GameScene.swift
//  8|_Kolosov_Roman_SnakeGame
//
//  Created by Роман Колосов on 24.06.2020.
//  Copyright © 2020 Roman N. Kolosov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private let counterClockWiseButtonName = "counterClockWiseButton"
    private let clockWiseButtonName = "clockWiseButton"
    private var snake: Snake?
    private var label : SKLabelNode?
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        
        let counterClockWiseButtonPosition = CGPoint(x: frame.minX + 30, y: frame.minY + 30)
        let clockWiseButtonPosition = CGPoint(x: frame.maxX - 80, y: frame.minY + 30)
        
        addControlButton(name: counterClockWiseButtonName, position: counterClockWiseButtonPosition)
        addControlButton(name: clockWiseButtonName, position: clockWiseButtonPosition)
        
        snake = Snake(position: CGPoint(x: frame.midX, y: frame.midY))
        addChild(snake!)
        
        createApple()
        
        //physicsWorld.contactDelegate = self
        
        //physicsBody?.contactTestBitMask
        //physicsBody?.collisionBitMask
       
    }
    
    private func addControlButton(name: String, position: CGPoint) {
        let button = SKShapeNode()
        button.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        
        button.position = position
        button.fillColor = .gray
        button.strokeColor = .gray
        button.lineWidth = 10
        button.name = name
        addChild(button)
    }
    
    private func createApple() {
        let randX = CGFloat.random(in: 0..<frame.maxX - 5)
        let randY = CGFloat.random(in: 0..<frame.maxY - 5)
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        
        addChild(apple)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchedNode = atPoint(touchLocation) as? SKShapeNode else { continue }
            
            if touchedNode.name == clockWiseButtonName {
                touchedNode.fillColor = .green
                snake?.moveClockWise()
            }
            else if touchedNode.name == counterClockWiseButtonName {
                touchedNode.fillColor = .green
                snake?.moveConterClockWise()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchedNode = atPoint(touchLocation) as? SKShapeNode else { continue }
            
            if touchedNode.name == clockWiseButtonName {
                touchedNode.fillColor = .gray
            }
            else if touchedNode.name == counterClockWiseButtonName {
                touchedNode.fillColor = .gray
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        snake?.move()
    }
}
