//
//  GameScene.swift
//  8|_Kolosov_Roman_SnakeGame
//
//  Created by Роман Колосов on 24.06.2020.
//  Copyright © 2020 Roman N. Kolosov. All rights reserved.
//

import SpriteKit
import GameplayKit

struct CollisionCategories {
    static let Snake: UInt32 = 1
    static let SnakeHead: UInt32 = 1 << 1
    static let Apple: UInt32 = 1 << 2
    static let EdgeBody: UInt32 = 1 << 3
}

class GameScene: SKScene {
    private let counterClockWiseButtonName = "counterClockWiseButton"
    private let clockWiseButtonName = "clockWiseButton"
    private let restartButtonName = "restartGameButton"
    private var snake: Snake?
    private var scoreLabel: SKLabelNode?
    private var scores: Int = 0 {
        didSet {
            scoreLabel?.text = String(scores)
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        
        let counterClockWiseButtonPosition = CGPoint(x: frame.minX + 30, y: frame.minY + 30)
        let clockWiseButtonPosition = CGPoint(x: frame.maxX - 80, y: frame.minY + 30)
        let restartButtonPosition = CGPoint(x: frame.midX - 22, y: frame.minY + 30)
        let restartLabelPosition = CGPoint(x: frame.midX, y: frame.minY + 95)
        let scoreLabelTextPosition = CGPoint(x: frame.midX, y: frame.maxY - 60)
        
        addControlButton(name: counterClockWiseButtonName, position: counterClockWiseButtonPosition)
        addControlButton(name: clockWiseButtonName, position: clockWiseButtonPosition)
        addControlButton(name: restartButtonName, position: restartButtonPosition)
        
        addLabel(text: "Restart Game", position: restartLabelPosition)
        addLabel(text: "Apples eaten:", position: scoreLabelTextPosition)
        
        scoreLabel = SKLabelNode()
        scoreLabel?.position = CGPoint(x: frame.midX, y: frame.maxY - 80)
        scoreLabel?.text = "0"
        scoreLabel?.fontColor = .red
        scoreLabel?.fontSize = 20
        addChild(scoreLabel!)
        
        snake = Snake(position: CGPoint(x: frame.midX, y: frame.midY))
        addChild(snake!)
        
        createApple()
        
        physicsWorld.contactDelegate = self
        
        physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
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
    
    private func addLabel(text: String, position: CGPoint) {
        let label = SKLabelNode()
        
        label.text = text
        label.position = position
        label.fontColor = .red
        label.fontSize = 20
        addChild(label)
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
            else if touchedNode.name == restartButtonName {
                scores = 0
                self.removeAllActions()
                self.removeAllChildren()
                view?.presentScene(scene)
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

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bytes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let collisionObject = bytes ^ CollisionCategories.SnakeHead
        
        switch collisionObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            scores += 1
            apple?.removeFromParent()
            createApple()
        case CollisionCategories.EdgeBody:
            snake?.moveAwayFromEdgeBody()
        default:
            break
        }
    }
}
