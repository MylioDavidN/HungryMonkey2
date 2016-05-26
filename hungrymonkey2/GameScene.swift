//
//  GameScene.swift
//  hungrymonkey2
//
//  Created by Dung Nguyen Tien on 5/24/16.
//  Copyright (c) 2016 David T. Nguyen. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let Banana: UInt32 = 1
    static let Monkey: UInt32 = 3
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var Monkey = SKSpriteNode()
    var Background = SKSpriteNode(imageNamed: "supporting_files/bg.jpg")
    
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    
    override func didMoveToView(view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        Background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        Background.zPosition = -5
        Background.size = CGSize(width: self.size.width, height: self.size.height)
        self.addChild(Background)
        
        TextureAtlas = SKTextureAtlas(named: "images")
        
        NSLog("\(TextureAtlas.textureNames)")
        
        for i in 2...3 {
            
            var Name = "monkey_\(i).png"
            TextureArray.append(SKTexture(imageNamed: Name))
            
        }
        
        Monkey = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0] as! String)
        Monkey.size = CGSize(width: 70, height: 140)
        Monkey.position = CGPoint(x: self.size.width / 2, y: self.size.height / 5)
        
        Monkey.physicsBody = SKPhysicsBody(rectangleOfSize: Monkey.size)
        Monkey.physicsBody?.affectedByGravity = false
        Monkey.physicsBody?.categoryBitMask = PhysicsCategory.Monkey
        Monkey.physicsBody?.dynamic = false
        
        
        var BananaTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("dropBananas"), userInfo: nil, repeats: true)
        
        
        self.addChild(Monkey)
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        //NSLog("Hello")
        
        var firstBody : SKPhysicsBody = contact.bodyA
        var secondBody : SKPhysicsBody = contact.bodyB
        
        if (((firstBody.categoryBitMask == PhysicsCategory.Monkey) && (secondBody.categoryBitMask == PhysicsCategory.Banana))
            || ((firstBody.categoryBitMask == PhysicsCategory.Banana) && (secondBody.categoryBitMask == PhysicsCategory.Monkey))) {
            CollisionMonkeyWithBanana(firstBody.node as! SKSpriteNode, Banana: secondBody.node as! SKSpriteNode)
        }
        
    }
    
    func CollisionMonkeyWithBanana(Monkey: SKSpriteNode, Banana: SKSpriteNode) {
        //NSLog("another banana eaten")
        
        Banana.removeFromParent()
    }
    
    
    func dropBananas() {
        var Banana = SKSpriteNode(imageNamed: "supporting_files/banana.png")
        
        var MinValue = self.size.width / 8
        var MaxValue = self.size.width - 20
        var DropPoint = UInt32(MaxValue - MinValue)
        
        Banana.position = CGPoint(x: CGFloat(arc4random_uniform(DropPoint)), y: self.size.height)
        Banana.physicsBody = SKPhysicsBody(rectangleOfSize: Banana.size)
        Banana.physicsBody?.categoryBitMask = PhysicsCategory.Banana
        Banana.physicsBody?.contactTestBitMask = PhysicsCategory.Monkey
        Banana.physicsBody?.affectedByGravity = false
        Banana.physicsBody?.dynamic = true
        
        
        let action = SKAction.moveToY(-70, duration: 3.0)
        let actionDone = SKAction.removeFromParent()
        Banana.runAction(SKAction.sequence([action, actionDone]))
        
        self.addChild(Banana)
        
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
