//
//  CustomizeScene.swift
//  Street Sweeper Mania
//
//  Created by Emmett Breen on 4/18/20.
//  Copyright © 2020 Emmett Breen. All rights reserved.
//

import UIKit
import SpriteKit

class CustomizeScene: SKScene {
    
    var road : SKSpriteNode!
    
    var statsButtonNode : SKSpriteNode!
    var customizeButtonNode : SKSpriteNode!
    var homeButtonNode : SKSpriteNode!
    
    var currentTruck : SKSpriteNode!
    
    var lineTimer : Timer!
    
    var truck1Node : SKSpriteNode!
    var truck2Node : SKSpriteNode!
    var truck3Node : SKSpriteNode!
    
    var truckScoreUse : Int!
    
    var truck2Block : SKSpriteNode!
    var truck3Block : SKSpriteNode!
    
    var truck21Node : SKSpriteNode!
    var truck22Node : SKSpriteNode!
    var truck23Node : SKSpriteNode!
    
    var truck21Block : SKSpriteNode!
    var truck22Block : SKSpriteNode!
    var truck23Block : SKSpriteNode!
    
    override func didMove(to view: SKView) {
        road = SKSpriteNode(imageNamed: "road")
        road.position = CGPoint(x: 0, y: 0)
        road.zPosition = -1
        road.size = self.size
        self.addChild(road)
        
        //let scoreUse = Int(Foundation.UserDefaults.standard.string(forKey: "Score")!)
        //let gameUse = Int(Foundation.UserDefaults.standard.string(forKey: "Games")!)
        //let timeUse = Int(Foundation.UserDefaults.standard.string(forKey: "Time")!)
        
        
        currentTruck = self.childNode(withName: "currentTruck") as? SKSpriteNode
        currentTruck.texture = SKTexture(imageNamed: Foundation.UserDefaults.standard.string(forKey: "CurrentTruck")!)
        currentTruck.position = CGPoint(x: 0, y: 0)
        currentTruck.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 4)
        currentTruck.zPosition = 1
        
        
        truck1Node = self.childNode(withName: "truck1") as? SKSpriteNode
        truck1Node.texture = SKTexture(imageNamed: "sweepertruck")
        truck1Node.zPosition = 1
        truck1Node.position = CGPoint(x: 0.35 * frame.size.width, y: frame.size.height / 3)
        truck1Node.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 5)
        truck1Node.zPosition = 1
        
        //truck2
        truck2Node = self.childNode(withName: "truck2") as? SKSpriteNode
        truck2Node.texture = SKTexture(imageNamed: "sweepertruck2")
        truck2Node.zPosition = 1
        truck2Node.position = CGPoint(x: 0.35 * frame.size.width, y: frame.size.height / 12)
        truck2Node.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 5)
        truck2Node.zPosition = 1
        
        truck2Block = SKSpriteNode(imageNamed: "lock1")
        truck2Block.position = CGPoint(x: truck2Node.position.x, y: truck2Node.position.y)
        truck2Block.size = CGSize(width: 2 * frame.size.width / 5, height: 2 * frame.size.width / 5)
        truck2Block.zPosition = 2
        self.addChild(truck2Block)
        if Foundation.UserDefaults.standard.bool(forKey: "Truck2"){
            truck2Block.removeFromParent()
        }
        
        truck3Node = self.childNode(withName: "truck3") as? SKSpriteNode
        truck3Node.texture = SKTexture(imageNamed: "sweepertruck3")
        truck3Node.zPosition = 1
        truck3Node.position = CGPoint(x: 0.35 * frame.size.width, y: -frame.size.height / 6)
        truck3Node.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 5)
        truck3Node.zPosition = 1
        
        truck3Block = SKSpriteNode(imageNamed: "lock2")
        truck3Block.position = CGPoint(x: truck3Node.position.x, y: truck3Node.position.y)
        truck3Block.size = CGSize(width: 2 * frame.size.width / 5, height: 2 * frame.size.width / 5)
        truck3Block.zPosition = 2
        self.addChild(truck3Block)
        
        if Foundation.UserDefaults.standard.bool(forKey: "Truck3"){
            truck3Block.removeFromParent()
        }
        
        truck21Node = self.childNode(withName: "truck21") as? SKSpriteNode
        truck21Node.texture = SKTexture(imageNamed: "radioactivesweeper")
        truck21Node.zPosition = 1
        truck21Node.position = CGPoint(x: -0.35 * frame.size.width, y: frame.size.height / 3)
        truck21Node.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 5)
        truck21Node.zPosition = 1
        
        truck21Block = SKSpriteNode(imageNamed: "lock3")
        truck21Block.position = CGPoint(x: truck21Node.position.x, y: truck21Node.position.y)
        truck21Block.size = CGSize(width: 2 * frame.size.width / 5, height: 2 * frame.size.width / 5)
        truck21Block.zPosition = 2
        self.addChild(truck21Block)
        if Foundation.UserDefaults.standard.bool(forKey: "Truck21"){
            truck21Block.removeFromParent()
        }
        
        
        truck22Node = self.childNode(withName: "truck22") as? SKSpriteNode
        truck22Node.texture = SKTexture(imageNamed: "radioactivesweeper2")
        truck22Node.zPosition = 1
        truck22Node.position = CGPoint(x: -0.35 * frame.size.width, y: frame.size.height / 12)
        truck22Node.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 5)
        truck22Node.zPosition = 1
        
        truck22Block = SKSpriteNode(imageNamed: "lock4")
        truck22Block.position = CGPoint(x: truck22Node.position.x, y: truck22Node.position.y)
        truck22Block.size = CGSize(width: 2 * frame.size.width / 5, height: 2 * frame.size.width / 5)
        truck22Block.zPosition = 2
        self.addChild(truck22Block)
        if Foundation.UserDefaults.standard.bool(forKey: "Truck22"){
            truck22Block.removeFromParent()
        }


        truck23Node = self.childNode(withName: "truck23") as? SKSpriteNode
        truck23Node.texture = SKTexture(imageNamed: "radioactivesweeper3")
        truck23Node.zPosition = 1
        truck23Node.position = CGPoint(x: -0.35 * frame.size.width, y: -frame.size.height / 6)
        truck23Node.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 5)
        truck23Node.zPosition = 1
        
        truck23Block = SKSpriteNode(imageNamed: "lock5")
        truck23Block.position = CGPoint(x: truck23Node.position.x, y: truck23Node.position.y)
        truck23Block.size = CGSize(width: 2 * frame.size.width / 5, height: 2 * frame.size.width / 5)
        truck23Block.zPosition = 2
        self.addChild(truck23Block)
        if Foundation.UserDefaults.standard.bool(forKey: "Truck23"){
            truck23Block.removeFromParent()
        }

        
        statsButtonNode = self.childNode(withName: "statsButton") as? SKSpriteNode
        statsButtonNode.texture = SKTexture(imageNamed: "stats")
        statsButtonNode.zPosition = 1
        statsButtonNode.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 10)
        statsButtonNode.position = CGPoint(x: -frame.size.width / 2 + statsButtonNode.size.width, y: -frame.size.height / 2 + statsButtonNode.size.height)
        
        homeButtonNode = self.childNode(withName: "homeButton") as? SKSpriteNode
        homeButtonNode.texture = SKTexture(imageNamed: "home")
        homeButtonNode.zPosition = 1
        homeButtonNode.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 10)
        homeButtonNode.position = CGPoint(x: 0, y: -frame.size.height / 2 + homeButtonNode.size.height)
        
        customizeButtonNode = SKSpriteNode(imageNamed: "customize")
        customizeButtonNode.zPosition = 1
        customizeButtonNode.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 8)
        customizeButtonNode.position = CGPoint(x: frame.size.width / 2 - 4 * customizeButtonNode.size.width / 5, y: -frame.size.height / 2 + customizeButtonNode.size.height)
        self.addChild(customizeButtonNode)
    
        
        lineTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(lineSpawn), userInfo: nil, repeats: true)
    }
    
    //creates road lines
    @objc func lineSpawn(){
        let line = SKSpriteNode(imageNamed: "line")
        let line2 = SKSpriteNode(imageNamed: "line")
        line.position = CGPoint(x: 0, y: frame.size.height / 2)
        line2.position = CGPoint(x: 0, y: frame.size.height / 2)
        line.size = CGSize(width: frame.size.width / 36, height: frame.size.height / 30)
        line2.size = CGSize(width: frame.size.width / 36, height: frame.size.height / 30)
        self.addChild(line)
        self.addChild(line2)
        let duration : TimeInterval = 5
        var actionArray = [SKAction] ()
        var actionArray2 = [SKAction] ()
        actionArray.append(SKAction.move(to: CGPoint(x: frame.size.width / 70, y: -frame.size.height / 2), duration: duration))
        actionArray2.append(SKAction.move(to: CGPoint(x: -frame.size.width / 70, y: -frame.size.height / 2), duration: duration))
        actionArray.append(SKAction.removeFromParent())
        actionArray2.append(SKAction.removeFromParent())
        line.run(SKAction.sequence(actionArray))
        line2.run(SKAction.sequence(actionArray2))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
    
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "statsButton" {
                let transition = SKTransition.crossFade(withDuration: 0.3)
                let statsScene = StatsScene(fileNamed: "StatsScene")
                self.view?.presentScene(statsScene!, transition: transition)
            }
            if nodesArray.first?.name == "homeButton" {
                let transition = SKTransition.crossFade(withDuration: 0.3)
                let menuScene = MenuScene(fileNamed: "MenuScene")
                self.view?.presentScene(menuScene!, transition: transition)
            }
            if nodesArray.first?.name == "truck1" {
                Foundation.UserDefaults.standard.set("sweepertruck", forKey: "CurrentTruck")
                Foundation.UserDefaults.standard.set(false, forKey: "Toxic")
                currentTruck.texture = SKTexture(imageNamed: Foundation.UserDefaults.standard.string(forKey: "CurrentTruck")!)
            }
            if nodesArray.first?.name == "truck2" {
                Foundation.UserDefaults.standard.set("sweepertruck2", forKey: "CurrentTruck")
                Foundation.UserDefaults.standard.set(false, forKey: "Toxic")
                currentTruck.texture = SKTexture(imageNamed: Foundation.UserDefaults.standard.string(forKey: "CurrentTruck")!)
            }
            if nodesArray.first?.name == "truck3" {
                Foundation.UserDefaults.standard.set("sweepertruck3", forKey: "CurrentTruck")
                Foundation.UserDefaults.standard.set(false, forKey: "Toxic")
                currentTruck.texture = SKTexture(imageNamed: Foundation.UserDefaults.standard.string(forKey: "CurrentTruck")!)
            }
            if nodesArray.first?.name == "truck21" {
                Foundation.UserDefaults.standard.set("radioactivesweeper", forKey: "CurrentTruck")
                Foundation.UserDefaults.standard.set(true, forKey: "Toxic")
                currentTruck.texture = SKTexture(imageNamed: Foundation.UserDefaults.standard.string(forKey: "CurrentTruck")!)
            }
            if nodesArray.first?.name == "truck22" {
                Foundation.UserDefaults.standard.set("radioactivesweeper2", forKey: "CurrentTruck")
                Foundation.UserDefaults.standard.set(true, forKey: "Toxic")
                currentTruck.texture = SKTexture(imageNamed: Foundation.UserDefaults.standard.string(forKey: "CurrentTruck")!)
            }
            if nodesArray.first?.name == "truck23" {
                Foundation.UserDefaults.standard.set("radioactivesweeper3", forKey: "CurrentTruck")
                Foundation.UserDefaults.standard.set(true, forKey: "Toxic")
                currentTruck.texture = SKTexture(imageNamed: Foundation.UserDefaults.standard.string(forKey: "CurrentTruck")!)
            }
        }
    }

}
