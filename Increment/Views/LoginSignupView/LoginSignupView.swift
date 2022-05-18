//
//  LoginSignupView.swift
//  Increment
//
//  Created by Uzair Mughal on 15/09/2021.
//

import SwiftUI

struct LoginSignupView: View {
    
    @ObservedObject var viewModel: LoginSignupViewModel
    
    var emailTextField: some View {
        TextField("Email", text: $viewModel.emailText)
    }
    
    var passwordTextField: some View {
        SecureField("Password", text: $viewModel.passwordText)
    }
    
    var actionButton: some View {
        Button(viewModel.buttonTitle) {
            
        }
    }
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(viewModel.subTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray2))
            
            VStack(spacing: 10) {
                emailTextField
                passwordTextField
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            actionButton
            Spacer()
        }
        .padding()
    }
}

struct LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginSignupView(viewModel: .init(mode: .login))
        }
    }
}
