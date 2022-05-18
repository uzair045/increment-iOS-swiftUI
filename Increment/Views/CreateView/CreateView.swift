//
//  CreateView.swift
//  Increment
//
//  Created by Uzair Mughal on 03/09/2021.
//

import SwiftUI

struct CreateView: View {
    
    @StateObject var viewModel = CreateChallengeVM()
    
    var dropdownList: some View {
        Group {
            DropdownView(viewModel: $viewModel.exerciseDropdown)
            DropdownView(viewModel: $viewModel.startAmountDropdown)
            DropdownView(viewModel: $viewModel.increaseDropdown)
            DropdownView(viewModel: $viewModel.lenghtDropdown)
        }
    }
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                Button(action: {
                    viewModel.send(action: .createChallenge)
                }, label: {
                    Text("Create")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.primary)
                })
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                mainContentView
            }
        }
        .alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil), content: {
            Alert(
                title: Text("Error!"),
                message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""),
                dismissButton: .default(Text("OK"), action: {
                    viewModel.error = nil
                })
            )
        })
        .navigationTitle("Create")
        .navigationBarBackButtonHidden(true)
        .padding(.bottom, 15)
        
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
