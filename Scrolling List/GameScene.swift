//
//  GameScene.swift
//  Scrolling List
//
//  Created by mitchell hudson on 8/1/16.
//  Copyright (c) 2016 mitchell hudson. All rights reserved.
//


/*
 
 This is a simple scrolling list that can be used with SpriteKit. 
 This is not a replacement for the UITableView. This provides 
 only a simple mechanism for scrolling a list sprite nodes. 
 
 The list arranges all sprites in a vertical list. Sprites 
 can be aligned to the left, right, or center. 
 
 When initializing a list you will set it's size. This will 
 determine the visible area for scrolling elements. 
 
 Initialize with a size like this: 
 
 list = ScrollingList(size: CGSize(width: 300, height: 400))
 
 Add sprite nodes as scrolling elements: 
 
 list.addNode(sprite)
 
 ScrollingList sends a selectedRowNode() message to it's delegate when a row is selected. 
 Note that dragging and tapping both involve touching a row. To differentiate between 
 tapping a row and scrolling the list, the list measures the distance from the start of a drag, 
 if the distance is less that 10 points selectedRowNode() is sent to the delegate.

 
 
 */


import SpriteKit

class GameScene: SKScene, ScrollListDelegate {
    
    let list: ScrollingList
    
    
    // MARK: - Scrolling Delegate
    
    func selectedRowNode(node: SKSpriteNode) {
        // be sure to check for nil here!
        print("Selected Row: \(node.name)")
    }
    
    
    
    override init(size: CGSize) {
        list = ScrollingList(size: CGSize(width: 300, height: 400))
        list.horizontalAlignmentMode = .Left
        list.color = UIColor.brownColor()
        
        super.init(size: size)
        
        list.delegate = self
        addChild(list)
        list.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        let rowSize = CGSize(width: 120, height: 40)
        
        for i in 0...19 {
            let hue: CGFloat = 1 / 20 * CGFloat(i)
            let color = UIColor(hue: hue, saturation: 0.8, brightness: 0.8, alpha: 1)
            let sprite = SKSpriteNode(color: color, size: rowSize)
            sprite.name = "row-\(i)"
            // 11sprite.userInteractionEnabled = true
            list.addNode(sprite)
        }
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
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInNode(self)
        let node = nodeAtPoint(location)
        
        print(node.name)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    
    // MARK: - Scrolling List Delegate 
    
    func scrollingListRowSelected(row: Int) {
        print("Scrolling List says you selected row: \(row)")
    }
    
}
