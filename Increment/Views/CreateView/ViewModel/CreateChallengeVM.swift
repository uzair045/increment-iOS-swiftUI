//
//  CreateChallengeVM.swift
//  Increment
//
//  Created by Uzair Mughal on 03/09/2021.
//

import SwiftUI
import Combine

typealias UserId = String

final class CreateChallengeVM: ObservableObject {
    
    @Published var exerciseDropdown = ChallengePartVM(type: .exercise)
    @Published var startAmountDropdown = ChallengePartVM(type: .startAmount)
    @Published var increaseDropdown = ChallengePartVM(type: .increase)
    @Published var lenghtDropdown = ChallengePartVM(type: .lenght)
    
    @Published var error: IncrementError?
    @Published var isLoading = false
    
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
        case createChallenge
    }
    
    init(userService: UserServiceProtocol = UserService(),
         challengeService: ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(action: Action) {
        switch action {
        case .createChallenge:
            self.isLoading = true
            self.currentUserId().flatMap { userId -> AnyPublisher<Void, IncrementError> in
                return self.createChallenge(userId: userId)
            }.sink { completion in
                self.isLoading = false
                switch completion {
                case let .failure(error):
                    self.error = error
                case .finished:
                    print("Finished")
                }
            } receiveValue: { _ in
                print("success")
            }.store(in: &cancellables)

        }
    }
    
    fileprivate func createChallenge(userId: UserId) -> AnyPublisher<Void, IncrementError> {
        guard let exrecise = exerciseDropdown.text,
              let startAmount = startAmountDropdown.number,
              let increase = increaseDropdown.number,
              let lenght = lenghtDropdown.number else {
            return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
        }
        
        let challenge = ChallengeModel(
            exercise: exrecise,
            startAmount: startAmount,
            increase: increase,
            lenght: lenght,
            userId: userId,
            startDate: Date()
        )
        
        return challengeService.create(challenge).eraseToAnyPublisher()
    }
    
    fileprivate func currentUserId() -> AnyPublisher<UserId, IncrementError> {
        print("getting user id...")
        return userService.currentUser().flatMap { user -> AnyPublisher<UserId, IncrementError> in
            if let userId = user?.uid {
                print("user logged in.....")
                return Just(userId)
                    .setFailureType(to: IncrementError.self)
                    .eraseToAnyPublisher()
            } else {
                print("user is being logged in anonymously.....")
                return self.userService
                    .signInAnonymously()
                    .map({$0.uid})
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}

extension CreateChallengeVM {
    
    struct ChallengePartVM: DropdownItemProtocol {
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formattedValue
        }
        
        var isSelected: Bool = false
        
        private let type: ChallengePartType
        
        
        init(type: ChallengePartType) {
            
            switch type {
            case .exercise:
                self.options = ExerciseOption.allCases.map({$0.toDropdownOption})
            case .startAmount:
                self.options = StartOption.allCases.map({$0.toDropdownOption})
            case .increase:
                self.options = IncreaseOption.allCases.map({$0.toDropdownOption})
            case .lenght:
                self.options = LenghtOption.allCases.map({$0.toDropdownOption})
            }
            self.type = type
            self.selectedOption = options.first!
        }
        
        enum ChallengePartType: String, CaseIterable {
            case exercise = "Exrecise"
            case startAmount = "Strat Amount"
            case increase = "Daily Increase"
            case lenght = "Challenge Lenght"
        }
        
        enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol {
            case pullups
            case pushups
            case setups
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue), formattedValue: rawValue.capitalized)
            }
        }
        
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formattedValue: "\(rawValue)")
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formattedValue: "+\(rawValue)")
            }
        }
        
        enum LenghtOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formattedValue: "\(rawValue) days")
            }
        }
    }
}

extension CreateChallengeVM.ChallengePartVM {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}
