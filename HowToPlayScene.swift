//
//  HowToPlayScene.swift
//  StreetSweeper
//
//  Created by Emmett Breen on 4/9/20.
//  Copyright © 2020 Emmett Breen. All rights reserved.
//

import UIKit
import SpriteKit

class HowToPlayScene: SKScene {

    var road : SKSpriteNode!
    
    var backNode : SKSpriteNode!
    var homeButtonNode : SKSpriteNode!
    
    var text : SKLabelNode!
    var text2 : SKLabelNode!
    var text3 : SKLabelNode!
    var text4 : SKLabelNode!
    
    var dirtL : SKSpriteNode!
    var dirtR : SKSpriteNode!
    var trashL : SKSpriteNode!
    var trashR : SKSpriteNode!
    var dumpster1 : SKSpriteNode!
    var dumpster2 : SKSpriteNode!
    
    var dumpButton : SKSpriteNode!
    var sweepL : SKSpriteNode!
    var sweepR : SKSpriteNode!
    var collectL : SKSpriteNode!
    var collectR : SKSpriteNode!
    
    var healthBar : SKSpriteNode!
    var trashBar : SKSpriteNode!
    var missBar : SKSpriteNode!
    var healthLabel : SKSpriteNode!
    var trashLabel : SKSpriteNode!
    var missLabel : SKSpriteNode!
    
    var arrow1 : SKSpriteNode!
    var arrow2 : SKSpriteNode!
    var arrow3 : SKSpriteNode!
    var arrow4 : SKSpriteNode!
    var arrow5 : SKSpriteNode!
    
    override func didMove(to view: SKView){
        
       /* if Foundation.UserDefaults.standard.bool(forKey: "dontShowAgain"){
            backNode = self.childNode(withName: "backButton") as? SKSpriteNode
            backNode.texture = SKTexture(imageNamed: "back")
            backNode.zPosition = 1
            backNode.size = CGSize(width: frame.size.width / 3, height: frame.size.height / 12)
            backNode.position = CGPoint(x: -frame.size.width / 2 + backNode.size.width / 2, y: -frame.size.height / 2 + backNode.size.height / 2)
        }*/
        
        //if Foundation.UserDefaults.standard.bool(forKey: "dontShowAgain") == false{
        homeButtonNode = self.childNode(withName: "homeButton") as? SKSpriteNode
        homeButtonNode.texture = SKTexture(imageNamed: "home")
        homeButtonNode.size = CGSize(width: frame.size.width / 6, height: frame.size.height / 12)
        homeButtonNode.position = CGPoint(x: -frame.size.width / 2 + homeButtonNode.size.width / 2, y: frame.size.height / 2 - homeButtonNode.size.height / 2)
        //}
        
        //set background as road
        road = SKSpriteNode(imageNamed: "road")
        road.position = CGPoint(x: 0, y: 0)
        road.size = self.size
        road.zPosition = -1
        self.addChild(road)
        
        //how to play text
        text = SKLabelNode(text: "How to Play:")
        text.position = CGPoint(x: 0, y: 4 * frame.size.height / 10)
        text.numberOfLines = 0
        text.fontSize = frame.size.width / 10
        text.fontName = "TrebuchetMS-Bold"
        text.fontColor = UIColor.black
        text.zPosition = 1
        text.preferredMaxLayoutWidth = frame.size.width
        self.addChild(text)
                
        
        let Hgap = frame.size.width / 10
        let Vgap = frame.size.height / 12
        
        //dump button set up
        dumpButton = SKSpriteNode(imageNamed: "dump")
        dumpButton.position = CGPoint(x: 0, y: -frame.size.height / 3)
        dumpButton.size = CGSize(width: frame.size.width / 5, height: 3 * frame.size.height / 10)
        self.addChild(dumpButton)
        
        dumpster1 = SKSpriteNode(imageNamed: "dumpster")
        dumpster1.position = CGPoint(x: 0, y: -frame.size.height / 4)
        dumpster1.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 12)
        dumpster1.zPosition = 2
        self.addChild(dumpster1)
        
        //sweep left button set up
        sweepL = SKSpriteNode(imageNamed: "sweepLeft")
        sweepL.position = CGPoint(x: -dumpButton.size.width - Hgap, y: -frame.size.height / 3 + Vgap)
        sweepL.size = CGSize(width: 3 * frame.size.width / 10, height: 3 * frame.size.height / 20)
        self.addChild(sweepL)
        
        dirtL = SKSpriteNode(imageNamed: "dirt")
        dirtL.position = CGPoint(x: sweepL.position.x, y: sweepL.position.y + frame.size.height / 15)
        dirtL.size = CGSize(width: frame.size.width / 8, height: frame.size.height / 12)
        dirtL.zPosition = 2
        self.addChild(dirtL)
        
        //sweep right button set up
        sweepR = SKSpriteNode(imageNamed: "sweepRight")
        sweepR.position = CGPoint(x: dumpButton.size.width + Hgap, y: -frame.size.height / 3 + Vgap)
        sweepR.size = CGSize(width: 3 * frame.size.width / 10, height: 3 * frame.size.height / 20)
        self.addChild(sweepR)
        
        dirtR = SKSpriteNode(imageNamed: "dirt")
        dirtR.position = CGPoint(x: sweepR.position.x, y: sweepR.position.y + frame.size.height / 15)
        dirtR.size = CGSize(width: frame.size.width / 8, height: frame.size.height / 12)
        dirtR.zPosition = 2
        self.addChild(dirtR)
        
        //collect left button set up
        collectL = SKSpriteNode(imageNamed: "collectLeft")
        collectL.position = CGPoint(x: -dumpButton.size.width - Hgap, y: -frame.size.height / 3 - Vgap)
        collectL.size = CGSize(width: 3 * frame.size.width / 10, height: 3 * frame.size.height / 20)
        self.addChild(collectL)
        
        trashL = SKSpriteNode(imageNamed: "trash")
        trashL.position = CGPoint(x: collectL.position.x, y: collectL.position.y + frame.size.height / 15)
        trashL.size = CGSize(width: frame.size.width / 8, height: frame.size.height / 12)
        trashL.zPosition = 2
        self.addChild(trashL)
        
        //collect right button set up
        collectR = SKSpriteNode(imageNamed: "collectRight")
        collectR.position = CGPoint(x: dumpButton.size.width + Hgap, y: -frame.size.height / 3 - Vgap)
        collectR.size = CGSize(width: 3 * frame.size.width / 10, height: 3 * frame.size.height / 20)
        self.addChild(collectR)
        
        trashR = SKSpriteNode(imageNamed: "trash")
        trashR.position = CGPoint(x: collectR.position.x, y: collectL.position.y + frame.size.height / 15)
        trashR.size = CGSize(width: frame.size.width / 8, height: frame.size.height / 12)
        trashR.zPosition = 2
        self.addChild(trashR)
        
        
        healthBar = SKSpriteNode(imageNamed: "healthBar")
        healthBar.position = CGPoint(x: 3 * frame.size.width / 10, y: frame.size.height / 4)
        healthBar.size = CGSize(width: frame.size.width / 24, height: frame.size.height / 6)
        self.addChild(healthBar)
        
        healthLabel = SKSpriteNode(imageNamed: "heart")
        healthLabel.position = CGPoint(x: 3 * frame.size.width / 10, y: 3 * frame.size.height / 8)
        healthLabel.size = CGSize(width: frame.size.width / 24, height: frame.size.height / 48)
        self.addChild(healthLabel)
        
        trashBar = SKSpriteNode(imageNamed: "trashBar")
        trashBar.position = CGPoint(x: -frame.size.width / 3, y: frame.size.height / 4)
        trashBar.size = CGSize(width: frame.size.width / 24, height: frame.size.height / 6)
        self.addChild(trashBar)
        
        trashLabel = SKSpriteNode(imageNamed: "trash")
        trashLabel.position = CGPoint(x: -frame.size.width / 3, y: 3 * frame.size.height / 8)
        trashLabel.size = CGSize(width: frame.size.width / 24, height: frame.size.height / 48)
        self.addChild(trashLabel)
        
        missBar = SKSpriteNode(imageNamed: "missBar")
        missBar.position = CGPoint(x: -4 * frame.size.width / 10, y: frame.size.height / 4)
        missBar.size = CGSize(width: frame.size.width / 24, height: frame.size.height / 6)
        self.addChild(missBar)
        
        missLabel = SKSpriteNode(imageNamed: "x")
        missLabel.position = CGPoint(x: -4 * frame.size.width / 10, y: 3 * frame.size.height / 8)
        missLabel.size = CGSize(width: frame.size.width / 24, height: frame.size.height / 48)
        self.addChild(missLabel)
        
        text2 = SKLabelNode(text: "Objective: Clear the streets by tapping the correct button (shown below) as dirt and gray trash cans appear. Dump your trash into the green dumpsters to recieve points. The game ends when 1) you let 4 pieces of garbage past the truck 2) you collected 25 items without dumping them 3) you clicked the wrong button 25 times")
        text2.position = CGPoint(x: 0, y: -frame.size.height / 10)
        text2.preferredMaxLayoutWidth = 14 * frame.size.width / 15
        text2.fontSize = frame.size.width / 20
        text2.fontName = "TrebuchetMS-Bold"
        text2.fontColor = UIColor.black
        text2.zPosition = 1
        text2.lineBreakMode = NSLineBreakMode.byCharWrapping
        text2.numberOfLines = 0
        self.addChild(text2)
        
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            /*if nodesArray.first?.name == "backButton" && Foundation.UserDefaults.standard.bool(forKey: "dontShowAgain"){
                let transition = SKTransition.crossFade(withDuration: 0.3)
                let statsScene = StatsScene(fileNamed: "StatsScene")
                self.view?.presentScene(statsScene!, transition: transition)
            }*/
            if nodesArray.first?.name == "homeButton" {
                let transition = SKTransition.crossFade(withDuration: 0.3)
                Foundation.UserDefaults.standard.set(true, forKey: "dontShowAgain")
                let menuScene = MenuScene(fileNamed: "MenuScene")
                self.view?.presentScene(menuScene!, transition: transition)
            }
            
        }
    }
}
