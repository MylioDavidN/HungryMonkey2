//
//  GameScene.swift
//  hungrymonkey2
//
//  Created by David T. Nguyen on 5/24/16.
//  Copyright (c) 2016 dunguk@gmail.com | All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let Banana: UInt32 = 1
    static let RottenBanana: UInt32 = 2
    static let Monkey: UInt32 = 3
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Game variables: change following variables to change speed of bananas
    // ======================================================
    var BananaScheduledInterval : NSTimeInterval = 1.0
    var RottenBananaScheduledInterval : NSTimeInterval = 2.0
    var BananaDropDuration : NSTimeInterval = 3.0
    var RottenBananaDropDuration : NSTimeInterval = 3.0
    // ===============================================
    
    var HighScore = Int()
    
    var Score = Int()
    var ScoreLbl = UILabel()
    
    var Monkey = SKSpriteNode()
    var Background = SKSpriteNode(imageNamed: "files/bg.jpg")
    var BgMusic: SKAudioNode = SKAudioNode(fileNamed: "files/bgmusic1.wav")
    
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    
    override func didMoveToView(view: SKView) {
        
        var HighScoreDefault = NSUserDefaults.standardUserDefaults()
        if (HighScoreDefault.valueForKey("HighScore") != nil) {
            HighScore = HighScoreDefault.valueForKey("HighScore") as! NSInteger
        }
        else {
            HighScore = 0
        }
        Score = 0
        
        physicsWorld.contactDelegate = self
        
        // get screen resolution
        let bounds = UIScreen.mainScreen().bounds
        // resize screen with new bounds
        self.scene?.size = CGSize(width: bounds.size.width, height: bounds.size.height)
        
        Background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        Background.zPosition = -5
        Background.size = CGSize(width: self.size.width, height: self.size.height)
        self.addChild(Background)
        
        // add background music
        //BgMusic = SKAudioNode(fileNamed: "files/bgmusic1.wav")
        self.addChild(BgMusic)
        //addChild(BgMusic)
        
        TextureAtlas = SKTextureAtlas(named: "images")
        
        NSLog("\(TextureAtlas.textureNames)")
        
        for i in 2...3 {
            
            let Name = "monkey_\(i).png"
            TextureArray.append(SKTexture(imageNamed: Name))
            
        }
        
        Monkey = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0] as String)
        Monkey.size = CGSize(width: 70, height: 140)
        Monkey.position = CGPoint(x: self.size.width / 2, y: self.size.height / 5)
        
        Monkey.physicsBody = SKPhysicsBody(rectangleOfSize: Monkey.size)
        Monkey.physicsBody?.affectedByGravity = false
        Monkey.physicsBody?.categoryBitMask = PhysicsCategory.Monkey
        Monkey.physicsBody?.dynamic = false
        
        
        var BananaTimer = NSTimer.scheduledTimerWithTimeInterval(BananaScheduledInterval, target: self, selector: Selector("dropBananas"), userInfo: nil, repeats: true)
        
        var RottenBananaTimer = NSTimer.scheduledTimerWithTimeInterval(RottenBananaScheduledInterval, target: self, selector: Selector("dropRottenBananas"), userInfo: nil, repeats: true)
        
        self.addChild(Monkey)
        
        ScoreLbl.text = "\(Score)"
        ScoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        //ScoreLbl.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
        ScoreLbl.textColor = UIColor.whiteColor()
        
        self.view?.addSubview(ScoreLbl)
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        //NSLog("Hello")
        
        let firstBody : SKPhysicsBody = contact.bodyA
        let secondBody : SKPhysicsBody = contact.bodyB
        
        if (((firstBody.categoryBitMask == PhysicsCategory.Monkey) && (secondBody.categoryBitMask == PhysicsCategory.Banana))
            || ((firstBody.categoryBitMask == PhysicsCategory.Banana) && (secondBody.categoryBitMask == PhysicsCategory.Monkey))) {
            CollisionMonkeyWithBanana(firstBody.node as! SKSpriteNode, Banana: secondBody.node as! SKSpriteNode)
        }
        else if (((firstBody.categoryBitMask == PhysicsCategory.Monkey) && (secondBody.categoryBitMask == PhysicsCategory.RottenBanana))
            || ((firstBody.categoryBitMask == PhysicsCategory.RottenBanana) && (secondBody.categoryBitMask == PhysicsCategory.Monkey))) {
            CollisionMonkeyWithRottenBanana(firstBody.node as! SKSpriteNode, RottenBanana: secondBody.node as! SKSpriteNode)
        }
        
    }
    
    func CollisionMonkeyWithBanana(Monkey: SKSpriteNode, Banana: SKSpriteNode) {
        //NSLog("another banana eaten")
        
        Banana.removeFromParent()
        
        Score = Score + 1
        //NSLog("\(Score)")
        
        ScoreLbl.text = "\(Score)"
    }
    
    func CollisionMonkeyWithRottenBanana(Monkey: SKSpriteNode, RottenBanana: SKSpriteNode) {
        
        // save final score
        var ScoreDefault = NSUserDefaults.standardUserDefaults()
        ScoreDefault.setValue(Score, forKey: "Score")
        ScoreDefault.synchronize()
        
        // if score is larger than current max, then update the max
        if (Score > HighScore) {
            var HighScoreDefault = NSUserDefaults.standardUserDefaults()
            HighScoreDefault.setValue(Score, forKey: "HighScore")
        }
        
        RottenBanana.removeFromParent()
        Monkey.removeFromParent()
        self.view?.presentScene(EndScene())
        ScoreLbl.removeFromSuperview()
        
        // stop background music
        BgMusic.runAction(SKAction.stop())
        
    }
    
    func dropBananas() {
        let Banana = SKSpriteNode(imageNamed: "files/banana.png")
        
        let MinValue = self.frame.size.width / 8
        let MaxValue = self.frame.size.width - 20
        let DropPoint = UInt32(MaxValue - MinValue)
        
        Banana.position = CGPoint(x: CGFloat(arc4random_uniform(DropPoint)), y: self.size.height)
        Banana.physicsBody = SKPhysicsBody(rectangleOfSize: Banana.size)
        Banana.physicsBody?.categoryBitMask = PhysicsCategory.Banana
        Banana.physicsBody?.contactTestBitMask = PhysicsCategory.Monkey
        Banana.physicsBody?.affectedByGravity = false
        Banana.physicsBody?.dynamic = true
        
        
        let action = SKAction.moveToY(-70, duration: BananaDropDuration)
        let actionDone = SKAction.removeFromParent()
        Banana.runAction(SKAction.sequence([action, actionDone]))
        
        self.addChild(Banana)
        
    }
    
    func dropRottenBananas() {
        let RottenBanana = SKSpriteNode(imageNamed: "files/rottenbanana4.png")
        
        let MinValue = self.frame.size.width / 8
        let MaxValue = self.frame.size.width - 20
        let DropPoint = UInt32(MaxValue - MinValue)
        
        RottenBanana.position = CGPoint(x: CGFloat(arc4random_uniform(DropPoint)), y: self.size.height)
        RottenBanana.physicsBody = SKPhysicsBody(rectangleOfSize: RottenBanana.size)
        RottenBanana.physicsBody?.categoryBitMask = PhysicsCategory.RottenBanana
        RottenBanana.physicsBody?.contactTestBitMask = PhysicsCategory.Monkey
        RottenBanana.physicsBody?.affectedByGravity = false
        RottenBanana.physicsBody?.dynamic = true
        
        
        let action = SKAction.moveToY(-70, duration: RottenBananaDropDuration)
        let actionDone = SKAction.removeFromParent()
        RottenBanana.runAction(SKAction.sequence([action, actionDone]))
        
        self.addChild(RottenBanana)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            Monkey.position.x = location.x
        }
        
        Monkey.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(TextureArray, timePerFrame: 0.3)))
        
    }
   
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            Monkey.position.x = location.x
        }
        
        Monkey.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(TextureArray, timePerFrame: 0.3)))
        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
