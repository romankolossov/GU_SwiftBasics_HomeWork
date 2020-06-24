//
//  GameViewController.swift
//  8|_Kolosov_Roman_SnakeGame
//
//  Created by Роман Колосов on 24.06.2020.
//  Copyright © 2020 Roman N. Kolosov. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as? SKView {
            let scene = GameScene()
            scene.scaleMode = .resizeFill
            
            view.presentScene(scene)
            
            view.showsPhysics = true
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
