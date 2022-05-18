//
//  SettingsView.swift
//  Increment
//
//  Created by Uzair Mughal on 14/09/2021.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        List(viewModel.itemViewModel.indices, id: \.self) { index in
            Button(action: {
                viewModel.tappedItem(at: index)
            }, label: {
                HStack {
                    Image(systemName: viewModel.item(at: index).iconName)
                    Text(viewModel.item(at: index).title)
                }
            })
        }.onAppear {
            self.viewModel.onAppear()
        }
        .navigationTitle(viewModel.title)
    }
}
