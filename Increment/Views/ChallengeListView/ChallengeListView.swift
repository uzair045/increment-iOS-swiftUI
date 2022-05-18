//
//  ChallengeListView.swift
//  Increment
//
//  Created by Uzair Mughal on 08/09/2021.
//

import SwiftUI

struct ChallengeListView: View {
    @StateObject private var viewModel = ChallengeListVM()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                VStack {
                    Text(error.localizedDescription)
                    Button("Retry") {
                        viewModel.send(action: .retry)
                    }
                    .padding(10)
                    .background(Rectangle().fill(Color.red).cornerRadius(5))
                }
            } else {
                mainContentView
            }
        }
    }
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [.init(.flexible(), spacing: 20), .init(.flexible())], spacing: 20) {
                    ForEach(viewModel.itemViewModels, id: \.self) { vm in
                        ChallengeItemView(viewModel: vm)
                    }
                }
                Spacer()
            }
            .padding(10)
        }
        .sheet(isPresented: $viewModel.showingCreateChallenge, content: {
            NavigationView {
                CreateView()
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        })
        .navigationBarItems(trailing: Button {
            viewModel.send(action: .create)
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
        })
        .navigationTitle(viewModel.title)
    }
}

struct ChallengeItemView: View {
    private let viewModel: ChallengeItemVM
    
    init(viewModel: ChallengeItemVM) {
        self.viewModel = viewModel
    }
    
    var titleView: some View {
        HStack {
            Text(viewModel.title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Image(systemName: "trash")
        }
    }
    
    var dailyIncreaseView: some View {
        HStack {
            Text(viewModel.dailyIncreaseText)
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
    }
    
    var body: some View {
        
        HStack {
            Spacer()
            VStack {
                titleView
                Text(viewModel.statusText)
                    .font(.system(size: 12, weight: .bold))
                    .padding(25)
                dailyIncreaseView
            }
            .padding(.vertical, 15)
            Spacer()
        }
        .background(
            Rectangle()
                .fill(Color.primaryButtonColor)
                .cornerRadius(5)
        )
    }
}
