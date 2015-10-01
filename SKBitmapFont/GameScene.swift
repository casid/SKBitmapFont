//
//  GameScene.swift
//  SKBitmapFont
//
//  Created by Andreas Hager on 01.10.15.
//  Copyright (c) 2015 Andreas Hager. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        let font = BitmapFont(name: "art.scnassets/font")
        let label = BitmapLabel(font: font)
        label.text = "abcC-0913 kf!=?.;_\nHello, Sir!"
        label.position.y = 300
        label.position.x = 300
        
        self.addChild(label)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
