//
//  StatusBar.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/24/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit


class StatusBar:SKNode {
    
    // MARK: - Private class variables
    private var statusBarBackground = SKSpriteNode()
    private var scoreLabel = SKLabelNode()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(lives: Int, score: Int) {
        self.init()
        
        self.setupStatusBar()
        self.setupStatusBarBackground()
        self.setupStatusBarScore(score: score)
        self.updateLives(lives: lives)
    }
    
    // MARK: - Setup
    private func setupStatusBar() {
    }
    
    private func setupStatusBarBackground() {
        // Make a CGRect that is as wide as the screen an 5% of the height of the screen
        let statusBarBackgroundSize = CGSizeMake(kViewSize.width, kViewSize.height * 0.05)
        
        // Make an SKSpriteNode that is a Black color and the size of statusBarBackgroundSize
        self.statusBarBackground = SKSpriteNode(color: SKColor.blackColor(), size: statusBarBackgroundSize)
        
        // Make the anchorPoint 0,0 so it is positioned using the lower left corner
        self.statusBarBackground.anchorPoint = CGPointZero
        
        // Position statusBarBackground on the left edge of the screen and 95% up the screen
        self.statusBarBackground.position = CGPoint(x: 0, y: kViewSize.height * 0.95)
        
        // Set the alpha to 75% opacity
        self.statusBarBackground.alpha = 0.75
        
        // Add statusBarBackground to the StatusBar node
        self.addChild(self.statusBarBackground)
    }
    
    private func setupStatusBarScore(score score: Int) {
        // Static Label
        let scoreText = GameFonts.sharedInstance.createLabel(string: "Score: ", labelType: GameFonts.LabelType.StatusBar)
        scoreText.position = CGPoint(x: self.statusBarBackground.size.width * 0.6, y: self.statusBarBackground.size.height / 2)
        self.statusBarBackground.addChild(scoreText)
        
        // Score Label
        self.scoreLabel = GameFonts.sharedInstance.createLabel(string: String(score), labelType: GameFonts.LabelType.StatusBar)
        let offsetX = self.statusBarBackground.size.width * 0.75
        let offsetY = self.statusBarBackground.size.height / 2
        self.scoreLabel.position = CGPoint(x: offsetX, y: offsetY)
        self.statusBarBackground.addChild(self.scoreLabel)
    }
    
    // MARK: - Public functions
    func updateScore(score score: Int) {
        self.scoreLabel.text = String(score)
    }
    
    func updateLives(lives lives: Int) {
        // First clear all of the sprites
        self.statusBarBackground.enumerateChildNodesWithName(SpriteName.PlayerLives) { node, _ in
            if let livesSprite = node as? SKSpriteNode {
                livesSprite.removeFromParent()
            }
        }
        
        // Get the X and Y points where we should draw the sprites
        var offsetX = CGFloat()
        let offsetY = self.statusBarBackground.size.height / 2
        
        // Redraw the sprites
        for i in 0..<lives  {
            let livesSprite = GameTextures.sharedInstance.spriteWithName(name: SpriteName.PlayerLives)
            
            offsetX = livesSprite.size.width + livesSprite.size.width * 1.5 * CGFloat(i)
            
            livesSprite.position = CGPoint(x: offsetX, y: offsetY)
            
            livesSprite.name = SpriteName.PlayerLives
            
            self.statusBarBackground.addChild(livesSprite)
        }
    }
}
