//
//  ContentView.swift
//  Increment
//
//  Created by Uzair Mughal on 03/09/2021.
//

import SwiftUI

struct LandingView: View {
    
    @StateObject private var viewModel = LandingViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.18)
                    Text("Increment")
                        .font(.system(size: 64, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    
                    NavigationLink(
                        destination: CreateView(), isActive: $viewModel.createPushed) {
                        Button(action: {
                                viewModel.createPushed = true
                        }, label: {
                            HStack {
                                Spacer()
                                Image(systemName: "plus.circle")
                                Text("Create a challenge")
                                Spacer()
                            }
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        })
                        .padding(15)
                        .buttonStyle(PrimaryButtonStyle())
                    }
                    
                    NavigationLink(
                        destination: LoginSignupView(viewModel: .init(mode: .login)),
                        isActive: $viewModel.loginSignupPushed
                    ) {
                        
                    }
                    Button("I already have an account") {
                        viewModel.loginSignupPushed = true
                    }
                    .foregroundColor(.white)
                }
                .padding(.bottom, 15)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .background(
                    Image("pullups")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(
                            Color.black.opacity(0.4)
                        )
                        .frame(width: proxy.size.width)
                        .edgesIgnoringSafeArea(.all)
                )
            }
        }
        .accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
