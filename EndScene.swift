//
//  EndScene.swift
//  StreetSweeper
//
//  Created by Emmett Breen on 4/8/20.
//  Copyright © 2020 Emmett Breen. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class EndScene: SKScene {
    
    var road : SKSpriteNode!
    
    var scoreLabel : SKLabelNode!
    var scoreSprite : SKSpriteNode!
    
    var score: Int!
    var menuNode : SKSpriteNode!
    
    var restartButtonNode : SKSpriteNode!
    
    var highScoreNode : SKSpriteNode!
    var highScoreLabel : SKLabelNode!
    
    var gameData : String!
    
    var newTruckNode : SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        //fix 0,0 as center
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        menuNode = self.childNode(withName: "menuButton") as? SKSpriteNode
        menuNode.texture = SKTexture(imageNamed: "home")
        menuNode.zPosition = 1
        menuNode.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 8)
        menuNode.position = CGPoint(x: -frame.size.width / 2 + menuNode.size.width / 2, y: -frame.size.height / 2 + menuNode.size.height / 2)
        
        restartButtonNode = self.childNode(withName: "restartButton") as? SKSpriteNode
        restartButtonNode.texture = SKTexture(imageNamed: "start")
        restartButtonNode.zPosition = 1
        restartButtonNode.position = CGPoint(x: 0, y: -frame.size.height / 4)
        restartButtonNode.size = CGSize(width: 3 * frame.size.width / 4, height: frame.size.height / 5)
        
        //set background as road
        road = SKSpriteNode(imageNamed: "road")
        road.position = CGPoint(x: 0, y: 0)
        road.size = self.size
        road.zPosition = -1
        self.addChild(road)
        
        //set up score label
        scoreLabel = SKLabelNode(text: "\(score ?? 0)")
        scoreLabel.position = CGPoint(x: 0, y: frame.size.height / 6.5)
        scoreLabel.fontSize = frame.size.width / 5
        scoreLabel.fontName = "TrebuchetMS-Bold"
        scoreLabel.fontColor = UIColor.black
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        //set up score image
        scoreSprite = SKSpriteNode(imageNamed: "score")
        scoreSprite.position = CGPoint(x: 0, y: frame.size.height / 3)
        scoreSprite.size = CGSize(width: 3 * frame.size.width / 4, height: frame.size.height / 8)
        scoreSprite.zPosition = 1
        self.addChild(scoreSprite)
        
        highScoreNode = SKSpriteNode(imageNamed: "highScore")
        highScoreNode.position = CGPoint(x: 0, y: frame.size.height / 16)
        highScoreNode.size = CGSize(width: 3 * frame.size.width / 4, height: frame.size.height / 8)
        highScoreNode.zPosition = 1
        self.addChild(highScoreNode)
        

        let value = Foundation.UserDefaults.standard.string(forKey: "Score")
        let Tvalue = Foundation.UserDefaults.standard.string(forKey: "Time")
        let Gvalue = Foundation.UserDefaults.standard.string(forKey: "Games")
        let intValue = Int(value!)!
        let intTvalue = Int(Tvalue!)!
        let intGvalue = Int(Gvalue!)!
        
        //if value == nil{
           // highScoreLabel = SKLabelNode(text: "0")
        //}
        //else{
        highScoreLabel = SKLabelNode(text: value)
        //}
        highScoreLabel.position = CGPoint(x: 0, y: -frame.size.height / 8)
        highScoreLabel.fontSize = frame.size.width / 5
        highScoreLabel.fontName = "TrebuchetMS-Bold"
        highScoreLabel.fontColor = UIColor.black
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
        
        
        newTruckNode = SKLabelNode(text: "Truck Unlocked!")
        newTruckNode.position = CGPoint(x: 0, y: scoreSprite.position.y + scoreSprite.size.height / 3)
        newTruckNode.fontSize = frame.size.width / 10
        newTruckNode.fontName = "TrebuchetMS-Bold"
        newTruckNode.fontColor = UIColor.white
        newTruckNode.zPosition = 2
        
        if Foundation.UserDefaults.standard.bool(forKey: "Truck2") == false && intValue >= 250{
            self.addChild(newTruckNode)
            Foundation.UserDefaults.standard.set(true, forKey: "Truck2")
            var intTruck = Int(Foundation.UserDefaults.standard.string(forKey: "TrucksUnlocked")!)!
            intTruck += 1
            Foundation.UserDefaults.standard.set("\(intTruck)", forKey: "TrucksUnlocked")
        }
        if Foundation.UserDefaults.standard.bool(forKey: "Truck3") == false && intGvalue >= 50{
            self.addChild(newTruckNode)
            Foundation.UserDefaults.standard.set(true, forKey: "Truck3")
            var intTruck = Int(Foundation.UserDefaults.standard.string(forKey: "TrucksUnlocked")!)!
            intTruck += 1
            Foundation.UserDefaults.standard.set("\(intTruck)", forKey: "TrucksUnlocked")
        }
        if Foundation.UserDefaults.standard.bool(forKey: "Truck21") == false && intTvalue >= 360{
            self.addChild(newTruckNode)
            Foundation.UserDefaults.standard.set(true, forKey: "Truck21")
            var intTruck = Int(Foundation.UserDefaults.standard.string(forKey: "TrucksUnlocked")!)!
            intTruck += 1
            Foundation.UserDefaults.standard.set("\(intTruck)", forKey: "TrucksUnlocked")
        }
        if Foundation.UserDefaults.standard.bool(forKey: "Truck22") == false && intValue >= 1000{
            self.addChild(newTruckNode)
            Foundation.UserDefaults.standard.set(true, forKey: "Truck22")
            var intTruck = Int(Foundation.UserDefaults.standard.string(forKey: "TrucksUnlocked")!)!
            intTruck += 1
            Foundation.UserDefaults.standard.set("\(intTruck)", forKey: "TrucksUnlocked")
        }
        if Foundation.UserDefaults.standard.bool(forKey: "Truck23") == false && intValue >= 2500{
            self.addChild(newTruckNode)
            Foundation.UserDefaults.standard.set(true, forKey: "Truck23")
            var intTruck = Int(Foundation.UserDefaults.standard.string(forKey: "TrucksUnlocked")!)!
            intTruck += 1
            Foundation.UserDefaults.standard.set("\(intTruck)", forKey: "TrucksUnlocked")
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
    
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "restartButton" {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let gameScene = GameScene(fileNamed: "GameScene")
                //gameScene?.highScore = self.highScore
                let intData = Int(Foundation.UserDefaults.standard.string(forKey: "Games")!)! + 1
                Foundation.UserDefaults.standard.set("\(intData)", forKey: "Games")
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "menuButton" {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let menuScene = MenuScene(fileNamed: "MenuScene")
                //menuScene?.scaleMode = .aspectFill
                //menuScene?.highScore = self.highScore
                self.view?.presentScene(menuScene!, transition: transition)
            }
        }
    }
    
}
