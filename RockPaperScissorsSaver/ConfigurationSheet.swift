//
//  ConfigurationSheet.swift
//  RockPaperScissorsSaver
//
//  Created by Alexander Barinov on 5/30/22.
//

import AppKit
import Foundation
import ScreenSaver

class ConfigurationSheet: NSObject {
    @IBOutlet var window: NSWindow?
    
    @IBOutlet var peacefulRadio: NSButton?
    @IBOutlet var endlessRadio: NSButton?
    @IBOutlet var deathRadio: NSButton?
        
    override init() {
        super.init()
        let bundle = Bundle(for: ConfigurationSheet.self)
        bundle.loadNibNamed("ConfigurationSheet", owner: self, topLevelObjects: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let mode = SaverMode.mode
        
        peacefulRadio?.state = .off
        endlessRadio?.state = .off
        deathRadio?.state = .off
        
        switch mode {
        case .endless:
            endlessRadio?.state = .on
        case .peaceful:
            peacefulRadio?.state = .on
        case .death:
            deathRadio?.state = .on
        }
    }
    
    @IBAction func modeSelected(_ sender: AnyObject?) {
        peacefulRadio?.state = .off
        endlessRadio?.state = .off
        deathRadio?.state = .off

        switch sender as? NSButton {
        case peacefulRadio:
            peacefulRadio?.state = .on
            SaverMode.mode = .peaceful
        case endlessRadio:
            endlessRadio?.state = .on
            SaverMode.mode = .endless
        case deathRadio:
            deathRadio?.state = .on
            SaverMode.mode = .death
        default:
            break
        }
    }
    
    @IBAction func buyCoffee(_ sender: AnyObject?) {
        if let url = URL(string: "https://www.buymeacoffee.com/alex.barinov") {
            NSWorkspace.shared.open(url)
        }
    }
    
    @IBAction func support(_ sender: AnyObject?) {
        if let url = URL(string: "mailto:saver@alex.barinov.name") {
            NSWorkspace.shared.open(url)
        }
    }
    
    @IBAction func close(_ sender: AnyObject?) {
        NSColorPanel.shared.close()

        if let window = window {
            window.sheetParent?.endSheet(window)
        }
    }
}
