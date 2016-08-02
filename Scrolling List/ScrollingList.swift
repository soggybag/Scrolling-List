//
//  ScrollingList.swift
//  Scrolling List
//
//  Created by mitchell hudson on 8/1/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import SpriteKit


// MARK: - Scrolling list protocol

protocol ScrollListDelegate {
    func selectedRowNode(node: SKSpriteNode)
}


// MARK: - Scrolling list alignment modes

enum ScrollListHorizontalAlignmentMode {
    case Center
    case Left
    case Right
}





class ScrollingList: SKSpriteNode {
    
    // MARK: - Properties
    
    let scrollNode: SKNode
    var rows = [SKSpriteNode]()
    var touchY: CGFloat = 0
    let cropNode: SKCropNode
    var horizontalAlignmentMode: ScrollListHorizontalAlignmentMode = .Center
    var verticalMargin: CGFloat = 5
    var scrollingListHeight: CGFloat = 0
    var scrollMin: CGFloat
    var scrollMax: CGFloat
    
    var delegate: ScrollListDelegate?
    
    
    
    // MARK: - Init
    
    init(size: CGSize) {
        scrollNode = SKNode()
        cropNode = SKCropNode()
        scrollMin = size.height / 2
        scrollMax = size.height / -2
        
        super.init(texture: nil, color: UIColor.redColor(), size: size)
        
        setup()
        setupScrollNode()
        setupCropNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Setup 
    
    func setup() {
        userInteractionEnabled = true
    }
    
    func setupScrollNode() {
        scrollNode.position.y = scrollMin
    }
    
    func setupCropNode() {
        let mask = SKSpriteNode(color: UIColor.orangeColor(), size: size)
        cropNode.maskNode = mask
        addChild(cropNode)
        cropNode.addChild(scrollNode)
    }
    
    
    
    
    // MARK: - Touch
    
    var previousY: CGFloat = 0
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //
        let touch = touches.first!
        let location = touch.locationInNode(self)
        
        touchY = location.y
        previousY = scrollNode.position.y
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //
        let touch = touches.first!
        let location = touch.locationInNode(self)
        
        var y = location.y - touchY + previousY // + scrollNode.position.y
        
        if y < scrollMin {
            y = scrollMin
        } else if y > scrollMax {
            y = scrollMax
        }
        
        scrollNode.position.y = y
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //
        print("Touches ended at Scrolling List")
        
        let touch = touches.first!
        let location = touch.locationInNode(self)
        
        let dy = abs(location.y - touchY)
        
        if dy > 10 { return }
        
        let rowNode = nodeAtPoint(location) as? SKSpriteNode
        
        guard let delegate = delegate, let node = rowNode else {
            return
        }
        
        delegate.selectedRowNode(node)
    }
    
    
    
    // MARK: - Update
    
    // TODO: Make the list spring and coast...
    
    
    
    
    // MARK: - Utility Methods
    
    func addNode(node: SKSpriteNode) {
        scrollNode.addChild(node)
        rows.append(node)
        print(node.frame)
        setupRows()
    }
    
    func setupRows() {
        var totalY: CGFloat = 0 // -(rows[0].size.height / 2 + verticalMargin)
        for row in rows {
            positionRowHorizontal(row)
            row.position.y = totalY - row.size.height / 2
            totalY -= row.size.height + verticalMargin
        }
        
        scrollingListHeight = -totalY + rows.last!.size.height + verticalMargin
        
        setScrollLimits()
    }
    
    func setScrollLimits() {
        scrollMin = size.height / 2
        scrollMax = scrollingListHeight - size.height // - scrollingListHeight // + scrollMin
    }
    
    func positionRowHorizontal(row: SKSpriteNode) {
        switch horizontalAlignmentMode {
        case .Center:
            row.position.x = 0
        case .Left:
            row.position.x = size.width / -2 + row.size.width / 2
        case .Right:
            row.position.x = size.width / 2 - row.size.width / 2
        }
    }
}
















