//
//  GameViewController.swift
//  StreetSweeper
//
//  Created by Emmett Breen on 4/3/20.
//  Copyright © 2020 Emmett Breen. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            //Foundation.UserDefaults.standard.set(false, forKey: "dontShowAgain")
            if Foundation.UserDefaults.standard.string(forKey: "CurrentTruck") == nil{
                Foundation.UserDefaults.standard.set("sweepertruck", forKey: "CurrentTruck")
            }
            if Foundation.UserDefaults.standard.bool(forKey: "dontShowAgain") == false {
                if let scene = SKScene(fileNamed: "HowToPlayScene") {
                // Set the scale mode to scale to fit the window
                //scene.scaleMode = .aspectFill
                // Present the scene
                    view.presentScene(scene)
                }
            }
            else {
                if let scene = SKScene(fileNamed: "MenuScene") {
                // Set the scale mode to scale to fit the window
                //scene.scaleMode = .aspectFill
                // Present the scene
                    view.presentScene(scene)
                }
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
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
