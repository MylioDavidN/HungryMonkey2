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
    
    var Background = SKSpriteNode(imageNamed: "files/junglebg4b.png")
    var LineHeight : CGFloat = 50.0
    
    //var ButtonHeight : Int32 = 30
    
    override func didMoveToView(view: SKView) {
        //NSLog("displaying EndScene")
        //scene?.backgroundColor = UIColor.whiteColor()
        
        // get screen resolution
        let bounds = UIScreen.mainScreen().bounds
        // resize screen with new bounds
        self.scene?.size = CGSize(width: bounds.size.width, height: bounds.size.height)
        
        Background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        Background.zPosition = -5
        Background.size = CGSize(width: self.size.width, height: self.size.height)
        self.addChild(Background)
        
        RestartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: view.frame.size.height / 8))
        RestartBtn.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 6 + 5*(LineHeight + 10))
        
        let RestartImage = UIImage(named: "restart") as UIImage?
        RestartBtn.setImage(RestartImage, forState: UIControlState.Normal)
        
        RestartBtn.setTitle("Restart", forState: UIControlState.Normal)
        RestartBtn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        RestartBtn.addTarget(self, action: Selector("Restart"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view?.addSubview(RestartBtn)
        
        var ScoreDefault = NSUserDefaults.standardUserDefaults()
        var Score = ScoreDefault.valueForKey("Score")
        NSLog("\(Score)")
        
        var HighScoreDefault = NSUserDefaults.standardUserDefaults()
        HighScore = HighScoreDefault.valueForKey("HighScore") as! NSInteger
        
        ScoreCaption = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: LineHeight))
        ScoreCaption.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 6)
        ScoreCaption.textColor = UIColor.whiteColor()
        ScoreCaption.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        ScoreCaption.text = "SCORE"
        ScoreCaption.textAlignment = NSTextAlignment.Center
        self.view?.addSubview(ScoreCaption)
        
        ScoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: LineHeight))
        ScoreLbl.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 6 + LineHeight + 10)
        ScoreLbl.textColor = UIColor.whiteColor()
        ScoreLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        ScoreLbl.text = "\(Score!)"
        ScoreLbl.textAlignment = NSTextAlignment.Center
        self.view?.addSubview(ScoreLbl)
        
        HighScoreCaption = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: LineHeight))
        HighScoreCaption.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 6 + 2*(LineHeight + 10))
        HighScoreCaption.textColor = UIColor.whiteColor()
        HighScoreCaption.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        HighScoreCaption.text = "HIGHSCORE"
        HighScoreCaption.textAlignment = NSTextAlignment.Center
        self.view?.addSubview(HighScoreCaption)
        
        HighScoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: LineHeight))
        HighScoreLbl.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 6 + 3*(LineHeight + 10))
        HighScoreLbl.textColor = UIColor.whiteColor()
        HighScoreLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        HighScoreLbl.text = "\(HighScore)"
        HighScoreLbl.textAlignment = NSTextAlignment.Center
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