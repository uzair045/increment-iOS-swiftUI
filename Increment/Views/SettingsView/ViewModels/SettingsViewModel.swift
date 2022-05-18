//
//  SettingsViewModel.swift
//  Increment
//
//  Created by Uzair Mughal on 14/09/2021.
//

import Combine
import SwiftUI

final class SettingsViewModel: ObservableObject {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Published private(set) var itemViewModel: [SettingsItemViewModel] = []
    let title = "Settings"
    
    
    func item(at index: Int) -> SettingsItemViewModel {
        return itemViewModel[index]
    }
    
    func tappedItem(at index: Int) {
        switch itemViewModel[index].type {
        case .mode:
            isDarkMode = !isDarkMode
            self.buildItems()
        default:
            break
        }
    }
    
    func onAppear() {
        self.buildItems()
    }
    
    fileprivate func buildItems() {
        self.itemViewModel = [
            .init(title: "Create Account", iconName: "person.circle", type: .account),
            .init(title: "Switch to \(isDarkMode ? "Light" : "Dark") Mode", iconName: "lightbulb", type: .mode),
            .init(title: "Privacy Policy", iconName: "shield", type: .privacy)
        ]
    }
}
