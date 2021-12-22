//
//  GameScene.swift
//  StreetSweeper
//
//  Copyright © 2021 Emmett Breen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var count = 0
    
    var recordData : String!
    var timeData : String!
    
    var road : SKSpriteNode!
    var sweeper : SKSpriteNode!
    var scoreLabel : SKLabelNode!
    var gameTimer : Timer!
    
    var managerTimer : Timer!
    
    var moveTimer : Timer!
    
    var lineTimer : Timer!
    var timeLabel : SKLabelNode!
    
    var timeBonusTimer : Timer!
    var timeBonusLabel : SKLabelNode!
    var bonus = 5
    
    var switchTimer : Timer!
    var switchLabel : SKLabelNode!
    var switchLabel2 : SKLabelNode!
    var prev = 0
    
    var bools = [true, false, false, false, false, false]
    
    var canSpawn = true
    
    var dirtLSprites = [SKSpriteNode(imageNamed: "dirt")]
    var dirtRSprites = [SKSpriteNode(imageNamed: "dirt")]
    var trashLSprites = [SKSpriteNode(imageNamed: "trash")]
    var trashRSprites = [SKSpriteNode(imageNamed: "trash")]
    var dumpsterSprites = [SKSpriteNode(imageNamed: "dumpster")]
    
    var lastDumpsterSpawn = 0
    
    var time = 0
    var tempScore = 0
    
    var highScore : Int = 0
    
    var score:Int = 0{
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var finalScore : Int = 0
    
    var dirt : SKSpriteNode!
    var trash : SKSpriteNode!
    
    var healthBar : SKSpriteNode!
    var trashBar : SKSpriteNode!
    var missBar : SKSpriteNode!
    var healthLabel : SKSpriteNode!
    var trashLabel : SKSpriteNode!
    var missLabel : SKSpriteNode!
    
    var dumpButtonNode : SKSpriteNode!
    var sweepLNode : SKSpriteNode!
    var sweepRNode : SKSpriteNode!
    var collectLNode : SKSpriteNode!
    var collectRNode : SKSpriteNode!
    
    var obj : SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        dirtLSprites.removeAll()
        dirtRSprites.removeAll()
        trashLSprites.removeAll()
        trashRSprites.removeAll()
        dumpsterSprites.removeAll()
        
        let Hgap = frame.size.width / 10
        let Vgap = frame.size.height / 12
        
        //dump button set up
        dumpButtonNode = self.childNode(withName: "dumpButton") as? SKSpriteNode
        dumpButtonNode.texture = SKTexture(imageNamed: "dump")
        dumpButtonNode.zPosition = 1
        dumpButtonNode.position = CGPoint(x: 0, y: -frame.size.height / 3)
        dumpButtonNode.size = CGSize(width: frame.size.width / 5, height: 3 * frame.size.height / 10)
        
        //sweep left button set up
        sweepLNode = self.childNode(withName: "sweepLeftButton") as? SKSpriteNode
        sweepLNode.texture = SKTexture(imageNamed: "sweepLeft")
        sweepLNode.zPosition = 1
        sweepLNode.position = CGPoint(x: -dumpButtonNode.size.width - Hgap, y: -frame.size.height / 3 + Vgap)
        sweepLNode.size = CGSize(width: 3 * frame.size.width / 10, height: 3 * frame.size.height / 20)
        
        //sweep right button set up
        sweepRNode = self.childNode(withName: "sweepRightButton") as? SKSpriteNode
        sweepRNode.texture = SKTexture(imageNamed: "sweepRight")
        sweepRNode.zPosition = 1
        sweepRNode.position = CGPoint(x: dumpButtonNode.size.width + Hgap, y: -frame.size.height / 3 + Vgap)
        sweepRNode.size = CGSize(width: 3 * frame.size.width / 10, height: 3 * frame.size.height / 20)
        
        //collect left button set up
        collectLNode = self.childNode(withName: "collectLeftButton") as? SKSpriteNode
        collectLNode.texture = SKTexture(imageNamed: "collectLeft")
        collectLNode.zPosition = 1
        collectLNode.position = CGPoint(x: -dumpButtonNode.size.width - Hgap, y: -frame.size.height / 3 - Vgap)
        collectLNode.size = CGSize(width: 3 * frame.size.width / 10, height: 3 * frame.size.height / 20)
        
        //collect right button set up
        collectRNode = self.childNode(withName: "collectRightButton") as? SKSpriteNode
        collectRNode.texture = SKTexture(imageNamed: "collectRight")
        collectRNode.zPosition = 1
        collectRNode.position = CGPoint(x: dumpButtonNode.size.width + Hgap, y: -frame.size.height / 3 - Vgap)
        collectRNode.size = CGSize(width: 3 * frame.size.width / 10, height: 3 * frame.size.height / 20)
        
        road = SKSpriteNode(imageNamed: "road")
        road.position = CGPoint(x: 0, y: 0)
        road.zPosition = -1
        road.size = self.size
        self.addChild(road)
        
        sweeper = self.childNode(withName: "sweeper") as? SKSpriteNode
        sweeper.texture = SKTexture(imageNamed: Foundation.UserDefaults.standard.string(forKey: "CurrentTruck")!)
        sweeper.position = CGPoint(x: 0, y: 0)
        sweeper.size = CGSize(width: frame.size.width * 2, height: frame.size.height * 2)
        sweeper.zPosition = 2
        let animationDuration : TimeInterval = 5.5
        var action = [SKAction] ()
        action.append(SKAction.resize(toWidth: frame.size.width / 4, height: frame.size.height / 4, duration: animationDuration))
        sweeper.run(SKAction.sequence(action))
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: frame.size.width / 4, y: 5 * frame.size.height / 12)
        scoreLabel.fontSize = frame.size.width / 12
        scoreLabel.fontName = "TrebuchetMS-Bold"
        scoreLabel.fontColor = UIColor.black
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        timeLabel = SKLabelNode(text: "Time: 0")
        timeLabel.position = CGPoint(x: -frame.size.width / 4, y: 5 * frame.size.height / 12)
        timeLabel.fontSize = frame.size.width / 12
        timeLabel.fontName = "TrebuchetMS-Bold"
        timeLabel.fontColor = UIColor.black
        timeLabel.zPosition = 1
        self.addChild(timeLabel)
        
        //frequency of creation
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incTimer), userInfo: nil, repeats: true)
        
        managerTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(manager), userInfo: nil, repeats: true)
        
        timeBonusTimer = Timer.scheduledTimer(timeInterval: 28, target: self, selector: #selector(timeBonus), userInfo: nil, repeats: true)
        
        switchTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(switchButtons), userInfo: nil, repeats: true)
        
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
    }
    
    //creates road lines
    func lineSpawn(){
        //if trashBar.size.height <= frame.size.height / 6 && healthBar.size.height >= 0{
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
    
    //timer label function
    @objc func incTimer(){
        if healthBar.size.height > 0 && missBar.size.height > 0 && trashBar.size.height > 0 {
            time += 1
        }
        timeLabel.text = "Time: \(time)"
    }
    
    @objc func timeBonus(){
        timeBonusLabel = SKLabelNode(text: "Time Bonus!   + \(bonus)")
        timeBonusLabel.position = CGPoint(x: 0, y: frame.size.height / 3)
        timeBonusLabel.fontSize = frame.size.width / 12
        timeBonusLabel.fontName = "TrebuchetMS-Bold"
        timeBonusLabel.fontColor = UIColor.white
        timeBonusLabel.zPosition = 1
        self.addChild(timeBonusLabel)
        if healthBar.size.height > 0 && missBar.size.height > 0 && trashBar.size.height > 0 {
            score += bonus
        }
        let wait = SKAction.wait(forDuration: 3)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([wait, remove])
        timeBonusLabel.run(sequence)
        bonus += 3
    }
    
    
    @objc func manager(){
        lineSpawn()
        moveObjs()
        dirtLSpawn()
        dirtRSpawn()
        dumpsterSpawn()
        trashLSpawn()
        trashRSpawn()
    }
    
    //dictates speed of objects down screen
    //time of animation
    let animationDuration : TimeInterval = 6
    
    func dirtLSpawn(){
        bools.shuffle()
        if Foundation.UserDefaults.standard.bool(forKey: "Toxic") == false{
            obj = SKSpriteNode(imageNamed: "dirt")
        }
        else{
            obj = SKSpriteNode(imageNamed: "acid")
        }
        if bools[0] && time % 60 > 6 && time % 60 < 56 {
            obj.position = CGPoint(x: -frame.size.width / 12, y: frame.size.height / 2)
            obj.size = CGSize(width: frame.size.width / 8, height: frame.size.height / 12)
            self.addChild(obj)
            var actionArray = [SKAction] ()
            actionArray.append(SKAction.move(to: CGPoint(x: -frame.size.width / 8, y: -frame.size.height / 2), duration: animationDuration))
            actionArray.append(SKAction.removeFromParent())
            obj.run(SKAction.sequence(actionArray))
            dirtLSprites.append(obj)
        }
    }
    
    func dirtRSpawn(){
        bools.shuffle()
        if Foundation.UserDefaults.standard.bool(forKey: "Toxic") == false{
            obj = SKSpriteNode(imageNamed: "dirt")
        }
        else{
            obj = SKSpriteNode(imageNamed: "acid")
        }
        if bools[0] && time % 60 > 6 && time % 60 < 56 {
            obj.position = CGPoint(x: frame.size.width / 12, y: frame.size.height / 2)
            obj.size = CGSize(width: frame.size.width / 8, height: frame.size.height / 12)
            self.addChild(obj)
            var actionArray = [SKAction] ()
            actionArray.append(SKAction.move(to: CGPoint(x: frame.size.width / 8, y: -frame.size.height / 2), duration: animationDuration))
            actionArray.append(SKAction.removeFromParent())
            obj.run(SKAction.sequence(actionArray))
            dirtRSprites.append(obj)
        }
    }
    
    func trashLSpawn(){
        bools.shuffle()
        if Foundation.UserDefaults.standard.bool(forKey: "Toxic") == false{
            obj = SKSpriteNode(imageNamed: "trash")
        }
        else{
            obj = SKSpriteNode(imageNamed: "acidcan")
        }
        if bools[0] && time % 60 > 6 && time % 60 < 56 && canSpawn{
            obj.position = CGPoint(x: -frame.size.width / 6, y: frame.size.height / 2)
            obj.size = CGSize(width: frame.size.width / 8, height: frame.size.height / 12)
            self.addChild(obj)
            var actionArray = [SKAction] ()
            actionArray.append(SKAction.move(to: CGPoint(x: -frame.size.width / 4, y: -frame.size.height / 2), duration: animationDuration))
            actionArray.append(SKAction.removeFromParent())
            obj.run(SKAction.sequence(actionArray))
            trashLSprites.append(obj)
        }
    }
    
    func trashRSpawn(){
        bools.shuffle()
        if Foundation.UserDefaults.standard.bool(forKey: "Toxic") == false{
            obj = SKSpriteNode(imageNamed: "trash")
        }
        else{
            obj = SKSpriteNode(imageNamed: "acidcan")
        }
        if bools[0] && time % 60 > 6 && time % 60 < 56 && canSpawn{
            obj.position = CGPoint(x: frame.size.width / 6, y: frame.size.height / 2)
            obj.size = CGSize(width: frame.size.width / 8, height: frame.size.height / 12)
            self.addChild(obj)
            var actionArray = [SKAction] ()
            actionArray.append(SKAction.move(to: CGPoint(x: frame.size.width / 4, y: -frame.size.height / 2), duration: animationDuration))
            actionArray.append(SKAction.removeFromParent())
            obj.run(SKAction.sequence(actionArray))
            trashRSprites.append(obj)
        }
    }
    
    func dumpsterSpawn(){
        bools.shuffle()
        if Foundation.UserDefaults.standard.bool(forKey: "Toxic") == false{
            obj = SKSpriteNode(imageNamed: "dumpster")
        }
        else{
            obj = SKSpriteNode(imageNamed: "aciddumpster")
        }
        if bools[0] && time > 13 && time % 3 == 0 || time - lastDumpsterSpawn > 20 {
            canSpawn = false
            lastDumpsterSpawn = time
            obj.size = CGSize(width: frame.size.width / 5, height: frame.size.height / 12)
            var actionArray = [SKAction] ()
            if time % 2 == 0{
                obj.position = CGPoint(x: frame.size.width / 6, y: frame.size.height / 2)
                self.addChild(obj)
                actionArray.append(SKAction.move(to: CGPoint(x: frame.size.width / 4, y: -frame.size.height / 2), duration: animationDuration))
            }
            else{
                obj.position = CGPoint(x: -frame.size.width / 6, y: frame.size.height / 2)
                    self.addChild(obj)
                actionArray.append(SKAction.move(to: CGPoint(x: -frame.size.width / 4, y: -frame.size.height / 2), duration: animationDuration))
            }
            actionArray.append(SKAction.removeFromParent())
            obj.run(SKAction.sequence(actionArray))
            dumpsterSprites.append(obj)
        }
    }
    
    //will remove dirt if position is near truck
    func sweepDirtL(){
        var i = 0
        var miss = 0
        let num = dirtLSprites.count
        //TODO: Make buttons flash y/n
        while i < dirtLSprites.count {
            if dirtLSprites[i].position.y < frame.size.height / 6 && dirtLSprites[i].position.y > -frame.size.height / 8 {
                dirtLSprites[i].removeFromParent()
                dirtLSprites.remove(at: i)
                loseCapacity()
                tempScore += 1
            }
            else{
                i += 1
                miss += 1
            }
        }
        if miss == num {
            loseMisses()
        }
    }
    
    func sweepDirtR(){
        var i = 0
        var miss = 0
        let num = dirtRSprites.count
        while i < dirtRSprites.count {
            if dirtRSprites[i].position.y < frame.size.height / 6 && dirtRSprites[i].position.y > -frame.size.height / 8 {
                dirtRSprites[i].removeFromParent()
                dirtRSprites.remove(at: i)
                loseCapacity()
                tempScore += 1
            }
            else{
                i += 1
                miss += 1
            }
        }
        if miss == num {
            loseMisses()
        }
    }
    
    func collectTrashL(){
        var i = 0
        var miss = 0
        let num = trashLSprites.count
        while i < trashLSprites.count {
            if trashLSprites[i].position.y < frame.size.height / 6 && trashLSprites[i].position.y > -frame.size.height / 8 {
                trashLSprites[i].removeFromParent()
                trashLSprites.remove(at: i)
                loseCapacity()
                tempScore += 1
            }
            else{
                i += 1
                miss += 1
            }
        }
        if miss == num {
            loseMisses()
        }
    }
    
    func collectTrashR(){
        var i = 0
        var miss = 0
        let num = trashRSprites.count
        while i < trashRSprites.count {
            if trashRSprites[i].position.y < frame.size.height / 6 && trashRSprites[i].position.y > -frame.size.height / 8 {
                trashRSprites[i].removeFromParent()
                trashRSprites.remove(at: i)
                loseCapacity()
                tempScore += 1
            }
            else{
                i += 1
                miss += 1
            }
        }
        if miss == num {
            loseMisses()
        }
    }
    
    func useDump(){
        var i = 0
        var miss = 0
        let num = dumpsterSprites.count
        while i < dumpsterSprites.count {
            if dumpsterSprites[i].position.y < frame.size.height / 6 && dumpsterSprites[i].position.y > -frame.size.height / 8 {
                dumpsterSprites.remove(at: i)
                trashBar.size.height = frame.size.height / 6
                trashBar.position.y = frame.size.height / 4
                score += tempScore
                tempScore = 0
            }
            else{
                i += 1
                miss += 1
            }
        }
        if miss == num {
            loseMisses()
        }
    }
    
    //function to keep track of objs y pos
    func moveObjs(){
        var i = 0
        var j = 0
        var k = 0
        var l = 0
        var m = 0
        while i < dirtLSprites.count {
            dirtLSprites[i].position.y -= 0.5 * (frame.size.height / CGFloat(animationDuration))
            if dirtLSprites[i].position.y <= -frame.size.height / 2 {
                loseHealth()
                //removes objects below frame from array
                //therefore bar is only resized when a new obj reaches bottom
                dirtLSprites.remove(at: i)
            }
            else{
                i += 1
            }
        }
        while j < dirtRSprites.count {
            dirtRSprites[j].position.y -= 0.5 * (frame.size.height / CGFloat(animationDuration))
            if dirtRSprites[j].position.y <= -frame.size.height / 2 {
                loseHealth()
                dirtRSprites.remove(at: j)
            }
            else{
                j += 1
            }
        }
        while k < trashLSprites.count {
            trashLSprites[k].position.y -= 0.5 * (frame.size.height / CGFloat(animationDuration))
            if trashLSprites[k].position.y <= -frame.size.height / 2 {
                loseHealth()
                trashLSprites.remove(at: k)
            }
            else{
                k += 1
            }
        }
        while l < trashRSprites.count {
            trashRSprites[l].position.y -= 0.5 * (frame.size.height / CGFloat(animationDuration))
            if trashRSprites[l].position.y <= -frame.size.height / 2 {
                loseHealth()
                trashRSprites.remove(at: l)
            }
            else{
                l += 1
            }
        }
        while m < dumpsterSprites.count {
            dumpsterSprites[m].position.y -= 0.5 * (frame.size.height / CGFloat(animationDuration))
            if dumpsterSprites[m].position.y <= -frame.size.height / 2 {
                dumpsterSprites.remove(at: m)
            }
            else{
                m += 1
            }
        }
    }
        
    //function to resize health bar
    func loseHealth(){
        if healthBar.size.height > 0 {
            healthBar.size.height -= frame.size.height / 24
            healthBar.position.y -= frame.size.height / 48
        }
        if healthBar.size.height <= 0 {
            endGame()
        }
    }
    
    func loseCapacity(){
        if trashBar.size.height > frame.size.height / 150 {
            trashBar.size.height -= frame.size.height / 150
            trashBar.position.y -= frame.size.height / 300
        }
        if trashBar.size.height <= frame.size.height / 150 {
            endGame()
        }
    }
    
    func loseMisses(){
        if missBar.size.height > frame.size.height / 150 {
            missBar.size.height -= frame.size.height / 150
            missBar.position.y -= frame.size.height / 300
        }
        if missBar.size.height <= frame.size.height / 150 {
            endGame()
        }
    }
    
    
    @objc func switchButtons(){
        let Hgap = frame.size.width / 10
        let Vgap = frame.size.width / 6
        count += 1
        
        switchLabel = SKLabelNode(text: "Button Swap!")
        switchLabel.position = CGPoint(x: 0, y: frame.size.height / 3)
        switchLabel.fontSize = frame.size.width / 10
        switchLabel.fontName = "TrebuchetMS-Bold"
        switchLabel.fontColor = UIColor.white
        switchLabel.zPosition = 1
        if count <= 5 {
            self.addChild(switchLabel)
            let wait = SKAction.wait(forDuration: 5)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([wait, remove])
            switchLabel.run(sequence)
        }
        
        switchLabel2 = SKLabelNode(text: "Sweep Left and Sweep Right!")
        switchLabel2.position = CGPoint(x: 0, y: frame.size.height / 6)
        switchLabel2.fontSize = frame.size.width / 15
        switchLabel2.fontName = "TrebuchetMS-Bold"
        switchLabel2.fontColor = UIColor.orange
        switchLabel2.zPosition = 1
        
        if count == 1 {
            sweepLNode.position = CGPoint(x: dumpButtonNode.size.width + Hgap, y: sweepLNode.position.y)
            sweepRNode.position = CGPoint(x: -dumpButtonNode.size.width - Hgap, y:sweepRNode.position.y)
            self.addChild(switchLabel2)
            let wait = SKAction.wait(forDuration: 5)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([wait, remove])
            switchLabel2.run(sequence)
        }
        if count == 2 {
            collectRNode.position = CGPoint(x: -dumpButtonNode.size.width - Hgap, y: collectRNode.position.y)
            collectLNode.position = CGPoint(x: dumpButtonNode.size.width + Hgap, y: collectLNode.position.y)
            switchLabel2.text = "Collect Left and Collect Right!"
            self.addChild(switchLabel2)
            let wait = SKAction.wait(forDuration: 5)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([wait, remove])
            switchLabel2.run(sequence)
        }
        if count == 3 {
            collectLNode.position = CGPoint(x: dumpButtonNode.size.width + Hgap, y: -frame.size.height / 3 + Vgap)
            sweepLNode.position = CGPoint(x: dumpButtonNode.size.width + Hgap, y: -frame.size.height / 3 - Vgap)
            switchLabel2.text = "Collect Left and Sweep Left!"
            self.addChild(switchLabel2)
            let wait = SKAction.wait(forDuration: 5)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([wait, remove])
            switchLabel2.run(sequence)
        }
        if count == 4 {
            collectRNode.position = CGPoint(x: -dumpButtonNode.size.width - Hgap, y: -frame.size.height / 3 + Vgap)
            sweepRNode.position = CGPoint(x: -dumpButtonNode.size.width - Hgap, y: -frame.size.height / 3 - Vgap)
            switchLabel2.text = "Collect Right and Sweep Right!"
            self.addChild(switchLabel2)
            let wait = SKAction.wait(forDuration: 5)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([wait, remove])
            switchLabel2.run(sequence)
        }
        if count == 5 {
            collectLNode.position = CGPoint(x: -dumpButtonNode.size.width - Hgap, y: -frame.size.height / 3 - Vgap)
            sweepRNode.position = CGPoint(x: dumpButtonNode.size.width + Hgap, y: -frame.size.height / 3 + Vgap)
            switchLabel2.text = "Collect Left and Sweep Right!"
            self.addChild(switchLabel2)
            let wait = SKAction.wait(forDuration: 5)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([wait, remove])
            switchLabel2.run(sequence)
        }
        if count == 6{
            switchLabel.text = "Final Swap!"
            self.addChild(switchLabel)
            let wait = SKAction.wait(forDuration: 4)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([wait, remove])
            switchLabel.run(sequence)
            collectLNode.position = CGPoint(x: -dumpButtonNode.size.width - Hgap, y: -frame.size.height / 3 + Vgap)
            collectRNode.position = CGPoint(x: -dumpButtonNode.size.width - Hgap, y: -frame.size.height / 3 - Vgap)
            switchLabel2.text = "Collect Left and Collect Right!"
            self.addChild(switchLabel2)
            switchLabel2.run(sequence)
        }
            
    }
    
    //function called after health bar is 0 and game is over
    func endGame(){
        //finalScore = score
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let endScene = EndScene(fileNamed: "EndScene")
        endScene?.score = self.score
        recordData = Foundation.UserDefaults.standard.string(forKey: "Score")
        let userDefaults = Foundation.UserDefaults.standard
        if recordData == nil || Int(recordData)! < score {
            userDefaults.set("\(score)", forKey: "Score")
        }
        timeData = Foundation.UserDefaults.standard.string(forKey: "Time")
        if timeData == nil || Int(timeData)! < time {
            userDefaults.set("\(time)", forKey: "Time")
        }
        self.view?.presentScene(endScene!, transition: transition)
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
                
            if nodesArray.first?.name == "dumpButton" {
                useDump()
            }
            if nodesArray.first?.name == "sweepLeftButton"  {
                sweepDirtL()
            }
            if nodesArray.first?.name == "sweepRightButton"  {
                sweepDirtR()
            }
            if nodesArray.first?.name == "collectLeftButton"  {
                collectTrashL()
            }
            if nodesArray.first?.name == "collectRightButton"  {
                collectTrashR()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
