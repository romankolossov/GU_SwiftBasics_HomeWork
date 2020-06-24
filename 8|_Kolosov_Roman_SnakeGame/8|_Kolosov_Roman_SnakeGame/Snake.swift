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
    
    
}


