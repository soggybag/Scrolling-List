//
//  GameScene.swift
//  Scrolling List
//
//  Created by mitchell hudson on 8/1/16.
//  Copyright (c) 2016 mitchell hudson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let list: ScrollingList
    
    
    
    
    override init(size: CGSize) {
        list = ScrollingList(size: CGSize(width: 375, height: 667))
        
        super.init(size: size)
        
        addChild(list)
        list.position = CGPoint(x: 0, y: size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
