//
//  ShapeType.swift
//  RockPaperScissorsSaver
//
//  Created by Alexander Barinov on 5/30/22.
//

import Foundation

enum ShapeType: String {
    case rock
    case paper
    case scissors
}

extension ShapeType {
    static func random() -> ShapeType {
        switch Int.random(in: 0 ..< 3) {
        case 0:
            return .rock
        case 1:
            return .paper
        default:
            return .scissors
        }
    }
    
    func stringValue() -> String {
        switch self {
        case .rock:
            return "🪨"
        case .paper:
            return "🧻"
        case .scissors:
            return "✂️"
        }
    }
}
