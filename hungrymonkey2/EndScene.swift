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
    
    var HighScore : Int!
    var ScoreLbl : UILabel!
    //var ScoreLbl = UILabel()
    var HighScoreLbl : UILabel!
    var ScoreCaption : UILabel!
    var HighScoreCaption : UILabel!
    
    //var ButtonHeight : Int32 = 30
    
    override func didMoveToView(view: SKView) {
        //NSLog("displaying EndScene")
        scene?.backgroundColor = UIColor.whiteColor()
        
        RestartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        RestartBtn.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 6 + 240)
        
        RestartBtn.setTitle("Restart", forState: UIControlState.Normal)
        RestartBtn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        RestartBtn.addTarget(self, action: Selector("Restart"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view?.addSubview(RestartBtn)
        
        var ScoreDefault = NSUserDefaults.standardUserDefaults()
        var Score = ScoreDefault.valueForKey("Score")
        NSLog("\(Score)")
        
        var HighScoreDefault = NSUserDefaults.standardUserDefaults()
        HighScore = HighScoreDefault.valueForKey("HighScore") as! NSInteger
        
        ScoreCaption = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        ScoreCaption.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 6)
        ScoreCaption.text = "SCORE"
        self.view?.addSubview(ScoreCaption)
        
        ScoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        ScoreLbl.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 6 + 60)
        ScoreLbl.text = "\(Score)"
        self.view?.addSubview(ScoreLbl)
        
        HighScoreCaption = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        HighScoreCaption.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 6 + 120)
        HighScoreCaption.text = "HIGHSCORE"
        self.view?.addSubview(HighScoreCaption)
        
        HighScoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        HighScoreLbl.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 6 + 180)
        HighScoreLbl.text = "\(HighScore)"
        self.view?.addSubview(HighScoreLbl)
        
        NSLog("\(HighScore)")
    }
    
    
    func Restart() {
        ScoreLbl.removeFromSuperview()
        HighScoreLbl.removeFromSuperview()
        ScoreCaption.removeFromSuperview()
        HighScoreCaption.removeFromSuperview()
        
        RestartBtn.removeFromSuperview()
        self.view?.presentScene(GameScene(), transition: SKTransition.crossFadeWithDuration(0.3))
        
    }
    
    
}