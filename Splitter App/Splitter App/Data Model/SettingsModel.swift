//
//  SettingsModel.swift
//  Splitter App
//
//  Created by Iron Man on 27/03/21.
//

import UIKit

final class SettingsModel {
    static let shared = SettingsModel()
    
    private(set) var data : [SettingsSection]!
    
    private init() {
        configure()
    }
    
    private func configure() {
        data = [SettingsSection]()
        data.append(SettingsSection(title: "", settings: [MenuData]()))
        
        data[0].settings.append(MenuData(title: "General", imageName: "settings"))
        data[0].settings.append(MenuData(title: "Accessibility", imageName: "accessibility"))
        data[0].settings.append(MenuData(title: "Privacy", imageName: "privacy"))
        
        data.append(SettingsSection(title: "", settings: [MenuData]()))
        data[1].settings.append(MenuData(title: "General", imageName: "settings"))
        
        data.append(SettingsSection(title: "", settings: [MenuData]()))
        
        data[2].settings.append(MenuData(title: "General", imageName: "settings"))
        data[2].settings.append(MenuData(title: "General", imageName: "settings"))
        data[2].settings.append(MenuData(title: "General", imageName: "settings"))
        data[2].settings.append(MenuData(title: "General", imageName: "settings"))
    }
        
    struct MenuData {
        var title : String
//        var subTitle : String?
        var imageName : String
//        var isDisclouserNeeded : Bool
    }
    
    struct SettingsSection {
        var title : String
        var settings : [MenuData]
    }
}
