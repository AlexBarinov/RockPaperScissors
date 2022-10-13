//
//  Shape.swift
//  RockPaperScissorsSaver
//
//  Created by Alexander Barinov on 5/29/22.
//

import Foundation
import AppKit

class Shape {
    private static var collisionRadius = 12.0
    private static var attributes: [NSAttributedString.Key : Any] = [:]
    
    private(set) var type: ShapeType
    private var x: Double
    private var y: Double
    private var speedX: Double
    private var speedY: Double
    private var frame: NSRect
    
    var mapXY: (Int, Int) {
        return (Int(x / Self.collisionRadius), Int(y / Self.collisionRadius))
    }
    
    var key: String {
        let (mx, my) = mapXY
        return "\(mx)_\(my)"
    }
    
    init(frame: NSRect) {
        self.frame = frame
        
        let dimension = min(frame.size.height, frame.size.width)
        let maxStep = dimension / 900
        
        x = Double.random(in: 0 ..< frame.size.width)
        y = Double.random(in: 0 ..< frame.size.height)
        speedX = Double.random(in: -maxStep ... maxStep)
        speedY = Double.random(in: -maxStep ... maxStep)
        type = ShapeType.random()
        
        Self.collisionRadius = dimension / 75
        Self.attributes[NSAttributedString.Key.font] = NSFont.systemFont(ofSize: 2 * Self.collisionRadius)
    }
    
    func move() {
        x += speedX
        y += speedY
        
        bounceIfRequired()
    }
    
    func beat() {
        switch type {
        case .rock:
            type = .paper
        case .paper:
            type = .scissors
        case .scissors:
            type = .rock
        }
    }
    
    func draw() {
        type.stringValue().draw(at: point, withAttributes: Self.attributes)
    }
    
    func near(to symbol: Shape) -> Bool {
        let dx = abs(symbol.x - x)
        let dy = abs(symbol.y - y)
        
        return dx * dx + dy * dy <= Self.collisionRadius * Self.collisionRadius
    }
}

extension Shape {
    private func bounceIfRequired() {
        if x < 0 - Self.collisionRadius && speedX < 0 {
            speedX = abs(speedX)
        }
        if x > frame.size.width - Self.collisionRadius && speedX > 0 {
            speedX = -abs(speedX)
        }
        if y < 0 - Self.collisionRadius && speedY < 0 {
            speedY = abs(speedY)
        }
        if y > frame.size.height - Self.collisionRadius && speedY > 0 {
            speedY = -abs(speedY)
        }
    }
    
    private var point: CGPoint {
        CGPoint(x: x, y: y)
    }
}
