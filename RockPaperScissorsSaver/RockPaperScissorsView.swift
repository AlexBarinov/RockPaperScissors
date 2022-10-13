//
//  RockPaperScissorsSaverView.swift
//  RockPaperScissorsSaver
//
//  Created by Alexander Barinov on 5/29/22.
//

import AppKit
import Foundation
import ScreenSaver

class RockPaperScissorsSaverView: ScreenSaverView {
    
    private lazy var configurationSheet = ConfigurationSheet()
    private var symbols: [Shape] = []
    
    override var hasConfigureSheet: Bool {
        true
    }

    override var configureSheet: NSWindow? {
        configurationSheet.window
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        for _ in 0 ..< Const.symbolCount {
            symbols.append(Shape(frame: frame))
        }
        animationTimeInterval = 1.0 / 30
    }
    
    override func draw(_ rect: NSRect) {
        super.draw(rect)

        NSColor.black.setFill()
        bounds.fill()

        if !isAnimating {
            return
        }
        
        for symbol in symbols {
            symbol.draw()
        }
    }
    
    override func animateOneFrame() {
        let mode = SaverMode.mode
        var map: [String: [Shape]] = [:]
        
        if mode != .death && symbols.count < Const.symbolCount {
            for _ in symbols.count ... Const.symbolCount {
                symbols.append(Shape(frame: frame))
            }
        }
        
        for symbol in symbols {
            symbol.move()
            
            let key = symbol.key
            if map[key] == nil {
                map[key] = []
            }
            map[key]?.append(symbol)
        }
        
        for symbol in symbols {
            let (mx, my) = symbol.mapXY
            
            var nearby: [Shape] = []
            var selected: [Shape] = []

            for x in mx - 1 ... mx + 1 {
                for y in my - 1 ... my + 1 {
                    nearby.append(contentsOf: map["\(x)_\(y)"] ?? [])
                }
            }
                        
            switch symbol.type {
            case .paper:
                selected = nearby.filter { $0.type == .rock && $0.near(to: symbol)}
            case .rock:
                selected = nearby.filter { $0.type == .scissors && $0.near(to: symbol)}
            case .scissors:
                selected = nearby.filter { $0.type == .paper && $0.near(to: symbol)}
            }
            
            switch mode {
            case .endless:
                selected.forEach { $0.beat() }
            case .death:
                selected.forEach { s in
                    symbols.removeAll { $0 === s }
                }
            case .peaceful:
                break
            }
        }

        setNeedsDisplay(frame)
    }
}
