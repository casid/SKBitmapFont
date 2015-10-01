//
//  GameScene.swift
//  SKBitmapFont
//
//  Created by Andreas Hager on 01.10.15.
//  Copyright (c) 2015 Andreas Hager. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let font = BitmapFont(name: "art.scnassets/font")
    
    override func didMoveToView(view: SKView) {
        addLeftAlignedLabel()
        addRightAlignedLabel()
        addCenterAlignedLabel()
    }
    
    private func addLeftAlignedLabel() {
        let label = BitmapLabel(font: font)
        label.text = "abcC-0913 kf!=?.;_\nHello, Sir!"
        label.position.y = self.size.height
        label.position.x = 0
        self.addChild(label)
    }
    
    private func addRightAlignedLabel() {
        let label = BitmapLabel(font: font)
        label.text = "abcC-0913 kf!=?.;_\nHello, Sir!"
        label.position.y = self.size.height - 200
        label.position.x = self.size.width
        label.horizontalAlignment = BitmapLabelHorizontalAlignment.Right
        self.addChild(label)
    }
    
    private func addCenterAlignedLabel() {
        let label = BitmapLabel(font: font)
        label.text = "abcC-0913 kf!=?.;_\nHello, Sir!"
        label.position.y = self.size.height - 400
        label.position.x = 0.5 * self.size.width
        label.horizontalAlignment = BitmapLabelHorizontalAlignment.Center
        self.addChild(label)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
