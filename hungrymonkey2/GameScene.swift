//
//  GameScene.swift
//  hungrymonkey2
//
//  Created by Dung Nguyen Tien on 5/24/16.
//  Copyright (c) 2016 David T. Nguyen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var Monkey = SKSpriteNode()
    var Background = SKSpriteNode(imageNamed: "supporting_files/bg.jpg")
    
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    
    override func didMoveToView(view: SKView) {
        
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
        
        
        var BananaTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("dropBananas"), userInfo: nil, repeats: true)
        
        
        self.addChild(Monkey)
        
    }
    
    func dropBananas() {
        var Banana = SKSpriteNode(imageNamed: "supporting_files/banana.png")
        
        var MinValue = self.size.width / 8
        var MaxValue = self.size.width - 20
        var DropPoint = UInt32(MaxValue - MinValue)
        
        Banana.position = CGPoint(x: CGFloat(arc4random_uniform(DropPoint)), y: self.size.height)
        
        let action = SKAction.moveToY(-70, duration: 3.0)
        Banana.runAction(SKAction.repeatActionForever(action))
        
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
