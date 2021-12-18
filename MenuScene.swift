//
//  MenuScene.swift
//  StreetSweeper
//
//  Created by Emmett Breen on 4/8/20.
//  Copyright © 2020 Emmett Breen. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    var sweeper : SKSpriteNode!
    
    //var highScore = Foundation.UserDefaults.standard.integer(forKey: "Key")
    
    var logo : SKSpriteNode!
    
    var startButtonNode : SKSpriteNode!
    
    //var howToPlayButtonNode: SKSpriteNode!
    
    var statsButtonNode : SKSpriteNode!
    var customizeButtonNode : SKSpriteNode!
    var homeButtonNode : SKSpriteNode!
    
    var currentTruck : SKSpriteNode!
    
    var gameData : String!
    
    var howToPlayButtonNode : SKSpriteNode!
    
    override func didMove(to view: SKView) {
        //Foundation.UserDefaults.standard.set(false, forKey: "Truck2")
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let Gvalue = Foundation.UserDefaults.standard.string(forKey: "Games")
        if Gvalue == nil{
            Foundation.UserDefaults.standard.set("0", forKey: "Games")
        }
        let record = Foundation.UserDefaults.standard.string(forKey: "Score")
        if record == nil{
            Foundation.UserDefaults.standard.set("0", forKey: "Score")
        }
        let Tvalue = Foundation.UserDefaults.standard.string(forKey: "Time")
        if Tvalue == nil{
            Foundation.UserDefaults.standard.set("0", forKey: "Time")
        }
        let TRvalue = Foundation.UserDefaults.standard.string(forKey: "TrucksUnlocked")
        if TRvalue == nil{
            Foundation.UserDefaults.standard.set("1", forKey: "TrucksUnlocked")
        }
        
        //background
        sweeper = self.childNode(withName: "sweeperTruck") as? SKSpriteNode
        sweeper.texture = SKTexture(imageNamed: Foundation.UserDefaults.standard.string(forKey: "CurrentTruck")!)
        sweeper.position = CGPoint(x: 0, y: 0)
        sweeper.size = CGSize(width: frame.size.width * 2, height: frame.size.height * 2)
        sweeper.zPosition = -1
        
        logo = SKSpriteNode(imageNamed: "streetsweepertitle")
        logo.position = CGPoint(x: 0, y: 7 *  frame.size.height / 24)
        logo.size = CGSize(width: 7 * frame.size.width / 8, height: 3 * frame.size.height / 10)
        logo.zPosition = 1
        self.addChild(logo)

        currentTruck = self.childNode(withName: "currentTruck") as? SKSpriteNode
        currentTruck.texture = SKTexture(imageNamed: Foundation.UserDefaults.standard.string(forKey: "CurrentTruck")!)
        currentTruck.position = CGPoint(x: 0, y: 0)
        currentTruck.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 4)
        currentTruck.zPosition = 1
        
        startButtonNode = self.childNode(withName: "start") as? SKSpriteNode
        startButtonNode.texture = SKTexture(imageNamed: "start")
        startButtonNode.position = CGPoint(x: 0, y: -0.225 * frame.size.height)
        startButtonNode.size = CGSize(width: 3 * frame.size.width / 4, height: frame.size.height / 6)
        startButtonNode.zPosition = 1
        
        customizeButtonNode = self.childNode(withName: "customizeButton") as? SKSpriteNode
        customizeButtonNode.texture = SKTexture(imageNamed: "customize")
        customizeButtonNode.zPosition = 1
        customizeButtonNode.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 10)
        customizeButtonNode.position = CGPoint(x: frame.size.width / 2 - customizeButtonNode.size.width, y: -frame.size.height / 2 + customizeButtonNode.size.height)
        
        statsButtonNode = self.childNode(withName: "statsButton") as? SKSpriteNode
        statsButtonNode.texture = SKTexture(imageNamed: "stats")
        statsButtonNode.zPosition = 1
        statsButtonNode.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 10)
        statsButtonNode.position = CGPoint(x: -frame.size.width / 2 + statsButtonNode.size.width, y: -frame.size.height / 2 + statsButtonNode.size.height)
        
        homeButtonNode = SKSpriteNode(imageNamed: "home")
        homeButtonNode.zPosition = 1
        homeButtonNode.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 8)
        homeButtonNode.position = CGPoint(x: 0, y: -frame.size.height / 2 + homeButtonNode.size.height)
        self.addChild(homeButtonNode)
        
        howToPlayButtonNode = self.childNode(withName: "howToPlayButton") as? SKSpriteNode
        howToPlayButtonNode.texture = SKTexture(imageNamed: "howToPlay")
        howToPlayButtonNode.zPosition = 1
        howToPlayButtonNode.size = CGSize(width: frame.size.width / 8, height: frame.size.height / 16)
        howToPlayButtonNode.position = CGPoint(x: 2 * frame.size.width / 5, y: -3 * frame.size.height / 10)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
    
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "start" {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let gameScene = GameScene(fileNamed: "GameScene")
                //gameScene?.highScore = self.highScore
                let intData = Int(Foundation.UserDefaults.standard.string(forKey: "Games")!)! + 1
                Foundation.UserDefaults.standard.set("\(intData)", forKey: "Games")
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "howToPlayButton" {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let howToPlayScene = HowToPlayScene(fileNamed: "HowToPlayScene")
                self.view?.presentScene(howToPlayScene!, transition: transition)
            }
            if nodesArray.first?.name == "statsButton" {
                let transition = SKTransition.crossFade(withDuration: 0.3)
                let statsScene = StatsScene(fileNamed: "StatsScene")
                self.view?.presentScene(statsScene!, transition: transition)
            }
            if nodesArray.first?.name == "customizeButton" {
                let transition = SKTransition.crossFade(withDuration: 0.3)
                let customizeScene = CustomizeScene(fileNamed: "CustomizeScene")
                self.view?.presentScene(customizeScene!, transition: transition)
            }
            if nodesArray.first?.name == "howToPlayButton" {
                let transition = SKTransition.crossFade(withDuration: 0.3)
                let howToPlayScene = HowToPlayScene(fileNamed: "HowToPlayScene")
                self.view?.presentScene(howToPlayScene!, transition: transition)
            }
            
        }
    }
}
