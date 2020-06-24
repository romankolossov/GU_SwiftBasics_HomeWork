//
//  SnakeHead.swift
//  8|_Kolosov_Roman_SnakeGame
//
//  Created by Роман Колосов on 24.06.2020.
//  Copyright © 2020 Roman N. Kolosov. All rights reserved.
//

import SpriteKit

class SnakeHead: SnakeBodyPart {
    override init(position: CGPoint) {
        super.init(position: position)
        
        //physicsBody?.categoryBitMask
        //physicsBody?.contactTestBitMask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
