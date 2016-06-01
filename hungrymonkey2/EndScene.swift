//
//  EndScene.swift
//  hungrymonkey2
//
//  Created by David T. Nguyen on 6/1/16.
//  Copyright © 2016 dunguk@gmail.com | All rights reserved.
//

import Foundation
import SpriteKit

class EndScene : SKScene {
    
    var RestartBtn : UIButton!
    
    override func didMoveToView(view: SKView) {
        //NSLog("displaying EndScene")
        scene?.backgroundColor = UIColor.whiteColor()
        
        RestartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        RestartBtn.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 7)
        
        RestartBtn.setTitle("Restart", forState: UIControlState.Normal)
        RestartBtn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        RestartBtn.addTarget(self, action: Selector("Restart"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view?.addSubview(RestartBtn)
    }
    
    
    func Restart() {
        RestartBtn.removeFromSuperview()
        self.view?.presentScene(GameScene(), transition: SKTransition.crossFadeWithDuration(0.3))
        
    }
    
    
}