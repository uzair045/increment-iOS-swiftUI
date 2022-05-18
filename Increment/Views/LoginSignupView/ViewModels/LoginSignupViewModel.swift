//
//  LoginSignupViewModel.swift
//  Increment
//
//  Created by Uzair Mughal on 15/09/2021.
//

import Foundation

final class LoginSignupViewModel: ObservableObject {
    private let mode: Mode
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var isValid = false
    private let userService: UserServiceProtocol
    
    init(
        mode: Mode,
        userService: UserServiceProtocol = UserService()
    ) {
        self.mode = mode
        self.userService = userService
    }
    
    var title: String {
        switch mode {
        case .login:
            return "Welcome back!"
        case .signup:
            return "Create an account"
        }
    }
    
    var subTitle: String {
        switch mode {
        case .login:
            return "Log in with your email"
        case .signup:
            return "Sign up via email"
        }
    }
    
    var buttonTitle: String {
        switch mode {
        case .login:
            return "Log in"
        case .signup:
            return "Sign up"
        }
    }
    
    func tappedActionButton() {
        switch mode {
        case .login:
            print("Login")
        case .signup:
            print("Signup")
            //userService.linkAccount(email, password
        }
    }
}

extension LoginSignupViewModel {
    enum Mode {
        case login
        case signup
    }
}
