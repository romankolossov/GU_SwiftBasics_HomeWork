//
//  Snake.swift
//  8|_Kolosov_Roman_SnakeGame
//
//  Created by Роман Колосов on 24.06.2020.
//  Copyright © 2020 Roman N. Kolosov. All rights reserved.
//

import SpriteKit

class Snake: SKShapeNode {
    private var body = [SnakeBodyPart]()
    private let moveSpeed: CGFloat = 125.0
    private var angle: CGFloat = 0.0
    
    convenience init(position: CGPoint) {
        self.init()
        
        let head = SnakeHead(position: position)
        body.append(head)
        
        addChild(head)
    }
    
    func addBodyPart() {
        let newBodyPart = SnakeBodyPart(position: body[0].position)
        body.append(newBodyPart)
        
        addChild(newBodyPart)
    }
    
    func moveClockWise() {
        angle += CGFloat.pi / 2
    }
    
    func moveConterClockWise() {
        angle -= CGFloat.pi / 2
    }
    
    func move() {
        moveHead(body[0])
        
        for i in 1..<body.count {
            let previousBodyPart = body[i-1]
            let currentBodyPart = body[i]
            
            moveBodyPart(currentBodyPart, previousPart: previousBodyPart)
        }
    }
    
    private func moveHead(_ head: SnakeBodyPart) {
        let dx = moveSpeed * sin(angle)
        let dy = moveSpeed * cos(angle)
        
        let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        
        head.run(moveAction)
    }
    
    private func moveBodyPart(_ part: SnakeBodyPart, previousPart: SnakeBodyPart) {
        let moveAction = SKAction.move(to: previousPart.position, duration: 0.1)
        
        part.run(moveAction)
    }
}


