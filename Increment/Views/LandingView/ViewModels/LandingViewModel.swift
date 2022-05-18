//
//  LandingViewModel.swift
//  Increment
//
//  Created by Uzair Mughal on 15/09/2021.
//

import Combine

final class LandingViewModel: ObservableObject {
    @Published var loginSignupPushed: Bool = false
    @Published var createPushed: Bool = false
}
