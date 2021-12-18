//
//  StatsScene.swift
//  Street Sweeper Mania
//
//  Created by Emmett Breen on 4/18/20.
//  Copyright © 2020 Emmett Breen. All rights reserved.
//

import UIKit
import SpriteKit

class StatsScene: SKScene {
    
    var road : SKSpriteNode!
    
    var traditionalLabel : SKLabelNode!
    
    var highScoreLabel : SKLabelNode!
    var highScoreValue: SKLabelNode!
    
    var longestTimeLabel : SKLabelNode!
    var longestTimeValue : SKLabelNode!
    
    var gamesLabel : SKLabelNode!
    var gamesValue : SKLabelNode!
    
    var trucksLabel : SKLabelNode!
    var trucksValue : SKLabelNode!
    
    var homeButtonNode: SKSpriteNode!
    var customizeButtonNode : SKSpriteNode!
    var statsButtonNode : SKSpriteNode!
    
    //var howToPlayButtonNode : SKSpriteNode!
    
    override func didMove(to view: SKView) {
        road = SKSpriteNode(imageNamed: "road")
        road.position = CGPoint(x: 0, y: 0)
        road.zPosition = -1
        road.size = self.size
        self.addChild(road)
        
        homeButtonNode = self.childNode(withName: "homeButton") as? SKSpriteNode
        homeButtonNode.texture = SKTexture(imageNamed: "home")
        homeButtonNode.zPosition = 1
        homeButtonNode.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 10)
        homeButtonNode.position = CGPoint(x: 0, y: -frame.size.height / 2 + homeButtonNode.size.height)
        
        customizeButtonNode = self.childNode(withName: "customizeButton") as? SKSpriteNode
        customizeButtonNode.texture = SKTexture(imageNamed: "customize")
        customizeButtonNode.zPosition = 1
        customizeButtonNode.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 10)
        customizeButtonNode.position = CGPoint(x: frame.size.width / 2 - customizeButtonNode.size.width, y: -frame.size.height / 2 + customizeButtonNode.size.height)
        
        statsButtonNode = SKSpriteNode(imageNamed: "stats")
        statsButtonNode.zPosition = 1
        statsButtonNode.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 8)
        statsButtonNode.position = CGPoint(x: -frame.size.width / 2 +  4 * statsButtonNode.size.width / 5, y: -frame.size.height / 2 + statsButtonNode.size.height)
        self.addChild(statsButtonNode)
        
        
        //traditional label
        traditionalLabel = SKLabelNode(text: "Statistics")
        traditionalLabel.position = CGPoint(x: 0, y: frame.size.height / 3)
        traditionalLabel.fontSize = frame.size.width / 5
        traditionalLabel.fontName = "TrebuchetMS-Bold"
        traditionalLabel.fontColor = UIColor.black
        traditionalLabel.zPosition = 1
        self.addChild(traditionalLabel)
        
        //set up high score
        highScoreLabel = SKLabelNode(text: "Highest Score:")
        highScoreLabel.position = CGPoint(x: 0, y: frame.size.height / 4)
        highScoreLabel.fontSize = frame.size.width / 10
        highScoreLabel.fontName = "TrebuchetMS-Bold"
        highScoreLabel.fontColor = UIColor.black
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
               
        //permanent high Score
        let value = Foundation.UserDefaults.standard.string(forKey: "Score")
        highScoreValue = SKLabelNode(text: value)
        highScoreValue.position = CGPoint(x: 0, y: frame.size.height / 6)
        highScoreValue.fontSize = frame.size.width / 8
        highScoreValue.fontName = "TrebuchetMS-Bold"
        highScoreValue.fontColor = UIColor.black
        highScoreValue.zPosition = 1
        self.addChild(highScoreValue)
        
        //set up longest time
        longestTimeLabel = SKLabelNode(text: "Longest Time:")
        longestTimeLabel.position = CGPoint(x: 0, y: frame.size.height / 12)
        longestTimeLabel.fontSize = frame.size.width / 10
        longestTimeLabel.fontName = "TrebuchetMS-Bold"
        longestTimeLabel.fontColor = UIColor.black
        longestTimeLabel.zPosition = 1
        self.addChild(longestTimeLabel)
        
        //permanent longest time
        let Tvalue = Foundation.UserDefaults.standard.string(forKey: "Time")
        longestTimeValue = SKLabelNode(text: Tvalue)
        longestTimeValue.position = CGPoint(x: 0, y: 0)
        longestTimeValue.fontSize = frame.size.width / 8
        longestTimeValue.fontName = "TrebuchetMS-Bold"
        longestTimeValue.fontColor = UIColor.black
        longestTimeValue.zPosition = 1
        self.addChild(longestTimeValue)
        
        //set up games played
        gamesLabel = SKLabelNode(text: "Games Played:")
        gamesLabel.position = CGPoint(x: 0, y: -frame.size.height / 12)
        gamesLabel.fontSize = frame.size.width / 10
        gamesLabel.fontName = "TrebuchetMS-Bold"
        gamesLabel.fontColor = UIColor.black
        gamesLabel.zPosition = 1
        self.addChild(gamesLabel)
        
        let Gvalue = Foundation.UserDefaults.standard.string(forKey: "Games")
        gamesValue = SKLabelNode(text: Gvalue)
        gamesValue.position = CGPoint(x: 0, y: -frame.size.height / 6)
        gamesValue.fontSize = frame.size.width / 8
        gamesValue.fontName = "TrebuchetMS-Bold"
        gamesValue.fontColor = UIColor.black
        gamesValue.zPosition = 1
        self.addChild(gamesValue)
        
        trucksLabel = SKLabelNode(text: "Trucks Unlocked:")
        trucksLabel.position = CGPoint(x: -frame.size.width / 16, y: -frame.size.height / 4)
        trucksLabel.fontSize = frame.size.width / 10
        trucksLabel.fontName = "TrebuchetMS-Bold"
        trucksLabel.fontColor = UIColor.black
        trucksLabel.zPosition = 1
        self.addChild(trucksLabel)
        
        let TRvalue = Foundation.UserDefaults.standard.string(forKey: "TrucksUnlocked")
        trucksValue = SKLabelNode(text: TRvalue)
        trucksValue.position = CGPoint(x: 2 * frame.size.width / 5, y: -frame.size.height / 4)
        trucksValue.fontSize = frame.size.width / 8
        trucksValue.fontName = "TrebuchetMS-Bold"
        trucksValue.fontColor = UIColor.black
        trucksValue.zPosition = 1
        self.addChild(trucksValue)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
    
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "customizeButton" {
                let transition = SKTransition.crossFade(withDuration: 0.3)
                let customizeScene = CustomizeScene(fileNamed: "CustomizeScene")
                self.view?.presentScene(customizeScene!, transition: transition)
            }
            if nodesArray.first?.name == "homeButton" {
                let transition = SKTransition.crossFade(withDuration: 0.3)
                let menuScene = MenuScene(fileNamed: "MenuScene")
                self.view?.presentScene(menuScene!, transition: transition)
            }
        }
    }
}
