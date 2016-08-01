//
//  ScrollingList.swift
//  Scrolling List
//
//  Created by mitchell hudson on 8/1/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import SpriteKit

class ScrollingList: SKNode {
    
    // MARK: - Properties
    
    let scrollNode: SKNode
    let size: CGSize
    var rows = [SKSpriteNode]()
    var touchPosition = CGPointZero
    
    
    // MARK: - Init
    
    init(size: CGSize) {
        self.size = size
        scrollNode = SKNode()
        
        super.init()
        
        
        addChild(scrollNode)
        
        userInteractionEnabled = true
        
        for i in 1...50 {
            let hue: CGFloat = 1 / 50 * CGFloat(i)
            addRow(UIColor(hue: hue, saturation: 0.8, brightness: 0.8, alpha: 1))
        }
        
        setupRows()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: - Touch
    
    // FIXME: Scroll jumps to top
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //
        print("List touches began")
        let touch = touches.first!
        let location = touch.locationInNode(scrollNode)
        touchPosition = location
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //
        
        // TODO: Add limits
        print("List touches moved")
        let touch = touches.first!
        let location = touch.locationInNode(self)
        
        var y = location.y - touchPosition.y
        
        print(size.height)
        print(size.height - CGFloat(rows.count) * 40)
        
        if y < 0 {
            y = 0
        } else if y > CGFloat(rows.count) * 40 - size.height {
            y = CGFloat(rows.count) * 40 - size.height
        }
        
        
        scrollNode.position.y = y
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //
        print("List touches ended")
    }
    
    
    
    
    
    // MARK: - Utility Methods
    
    func addRow(color: UIColor) {
        let rowSize = CGSize(width: size.width, height: 40)
        let row = SKSpriteNode(color: color, size: rowSize)
        row.anchorPoint = CGPoint(x: 0, y: 1)
        scrollNode.addChild(row)
        rows.append(row)
    }
    
    func setupRows() {
        for i in 0 ..< rows.count {
            rows[i].position.y = CGFloat(i) * -40
            print(rows[i].position)
        }
    }
}
















