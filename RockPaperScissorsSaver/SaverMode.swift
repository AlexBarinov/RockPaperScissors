//
//  SaverMode.swift
//  RockPaperScissorsSaver
//
//  Created by Alexander Barinov on 5/30/22.
//

import Foundation
import ScreenSaver

enum SaverMode: Int {
    case endless = 0
    case peaceful = 1
    case death = 2
}

extension SaverMode {
    static var mode: SaverMode {
        get {
            let defaults = ScreenSaverDefaults(forModuleWithName: "RockPaperScissors")
            let modeInDefaults = defaults?.integer(forKey: "mode") ?? 0
            return SaverMode(rawValue: modeInDefaults) ?? .endless
        }
        set {
            let defaults = ScreenSaverDefaults(forModuleWithName: "RockPaperScissors")
            defaults?.set(newValue.rawValue, forKey: "mode")
            defaults?.synchronize()
        }
    }
}
