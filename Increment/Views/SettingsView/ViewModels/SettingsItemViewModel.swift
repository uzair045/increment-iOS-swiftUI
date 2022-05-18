//
//  SettingsItemViewModel.swift
//  Increment
//
//  Created by Uzair Mughal on 14/09/2021.
//

import Foundation

extension SettingsViewModel {
    struct SettingsItemViewModel {
        let title: String
        let iconName: String
        let type: SettingsItemType
    }
    
    enum SettingsItemType {
        case account
        case mode
        case privacy
    }
}
