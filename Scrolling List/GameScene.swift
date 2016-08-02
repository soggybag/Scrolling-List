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
    let label: SKLabelNode
    
    
    // MARK: - Scrolling Delegate
    
    // SCrollingList sends it's delegate this message along with the node that 
    // tapped when a tap occurs.
    
    func selectedRowNode(node: SKSpriteNode) {
        // Check the node name to decide what to do here...
        print("Selected Row: \(node.name)")
        if node.name != nil {
            label.text = node.name
        }
    }
    
    
    
    // MARK: - Init
    
    override init(size: CGSize) {
        
        // Create a ScrollingList of size
        list = ScrollingList(size: CGSize(width: 300, height: 400))
        // Set the Alignment mode: .Left, .Right, .Center
        list.horizontalAlignmentMode = .Left
        // Set the background Color
        list.color = UIColor.brownColor()
        
        // This label is used to show the effect of tapping a row
        label = SKLabelNode(fontNamed: "Helvetica")
        
        // Must call super.init()
        super.init(size: size)
        
        // Set up the label and the list
        setupLabel()
        setupList()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Setup 
    
    func setupLabel() {
        // Setup Label
        addChild(label)
        label.position = CGPoint(x: size.width / 2, y: size.height / 2 - 250)
        label.text = "????"
    }
    
    func setupList() {
        // Assign this class as the delegate for the List, for tap on rows.
        list.delegate = self
        // Add the list to this scene
        addChild(list)
        // Position the list. THe reference point is in the center.
        list.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        // Generate some rows to appear in the list
        // The size for each row. Comment the two lines below to make all of the rows the same size.
        var rowSize = CGSize(width: 300, height: 40)
        
        // Make 20 rows.
        for i in 0...19 {
            // Set the color of a row
            let hue: CGFloat = 1 / 20 * CGFloat(i)
            let color = UIColor(hue: hue, saturation: 0.8, brightness: 0.8, alpha: 1)
            
            // Randomize the size of a row
            rowSize.height = CGFloat(arc4random() % 40) + 30
            rowSize.width = CGFloat(arc4random() % 60) + 240
            
            // Make a Sprite node row
            let sprite = SKSpriteNode(color: color, size: rowSize)
            // Give the row a name. This will help with handling taps on a row.
            sprite.name = "row-\(i)"
            
            // Add the row to the list
            list.addNode(sprite)
        }

    }
    
    
    
    // MARK: - View Lifecycle
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
    }
    
    
    
    
    // MARK: - Touches
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 
        
    }
    
    
    
    // MARK: - Update
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
   
}
