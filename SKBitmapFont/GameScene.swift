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
        //testHorizontalAlignment()
        testVerticalAlignment()
    }
    
    private func testHorizontalAlignment() {
        addLeftAlignedLabel()
        addRightAlignedLabel()
        addCenterAlignedLabel()
    }
    
    private func testVerticalAlignment() {
        addTopAlignedLabel()
        addVCenterAlignedLabel()
        addBottomAlignedLabel()
    }
    
    private func addLeftAlignedLabel() {
        let label = BitmapLabel(font: font)
        label.text = "abcC-0913 kf!=?.;_\nHello, Sir!"
        label.position.x = 0
        label.position.y = self.size.height
        self.addChild(label)
    }
    
    private func addRightAlignedLabel() {
        let label = BitmapLabel(font: font)
        label.text = "abcC-0913 kf!=?.;_\nHello, Sir!"
        label.position.x = self.size.width
        label.position.y = self.size.height - 200
        label.horizontalAlignment = BitmapLabelHorizontalAlignment.Right
        self.addChild(label)
    }
    
    private func addCenterAlignedLabel() {
        let label = BitmapLabel(font: font)
        label.text = "abcC-0913 kf!=?.;_\nHello, Sir!"
        label.position.x = 0.5 * self.size.width
        label.position.y = self.size.height - 400
        label.horizontalAlignment = BitmapLabelHorizontalAlignment.Center
        self.addChild(label)
    }
    
    private func addTopAlignedLabel() {
        let label = BitmapLabel(font: font)
        label.text = "Top"
        label.position.x = 0
        label.position.y = self.size.height
        self.addChild(label)
    }
    
    private func addVCenterAlignedLabel() {
        let label = BitmapLabel(font: font)
        label.text = "a\n\n\ncenter\naa\naaa\naaaa"
        label.position.x = 0.5 * self.size.width
        label.position.y = 0.5 * self.size.height
        label.horizontalAlignment = BitmapLabelHorizontalAlignment.Center
        label.verticalAlignment = BitmapLabelVerticalAlignment.Center
        self.addChild(label)
    }
    
    private func addBottomAlignedLabel() {
        let label = BitmapLabel(font: font)
        label.text = "Bottom"
        label.position.x = 0
        label.position.y = 0
        label.verticalAlignment = BitmapLabelVerticalAlignment.Bottom
        self.addChild(label)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
