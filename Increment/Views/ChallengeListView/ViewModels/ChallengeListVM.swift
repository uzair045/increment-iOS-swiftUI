//
//  ChallengeListVM.swift
//  Increment
//
//  Created by Uzair Mughal on 08/09/2021.
//

import Combine

final class ChallengeListVM: ObservableObject {
    
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    @Published private(set) var itemViewModels: [ChallengeItemVM] = []
    @Published private(set) var error: IncrementError?
    @Published private(set) var isLoading = false
    @Published var showingCreateChallenge = false
    
    let title = "Challenges"
    
    enum Action {
        case retry
        case create
    }
    
    init(
        userService: UserServiceProtocol = UserService(),
        challengeService: ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeService
        self.observeChallenges()
    }
    
    func send(action: Action) {
        switch action {
        case .retry:
            self.observeChallenges()
        case .create:
            self.showingCreateChallenge = true
        }
    }
    
    private func observeChallenges() {
        self.isLoading = true
        self.userService.currentUser()
            .compactMap({$0?.uid})
            .flatMap({ [weak self] userId -> AnyPublisher<[ChallengeModel], IncrementError> in
                guard let self = self else { return Fail(error: .default()).eraseToAnyPublisher()}
                return self.challengeService.observeChallenges(userId: userId)
            })
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case let .failure(error):
                    self.error = error
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] challenges in
                guard let self = self else { return }
                self.isLoading = false
                self.error = nil
                self.showingCreateChallenge = false
                self.itemViewModels = challenges.map({.init($0)})
            }
            .store(in: &cancellables)
        
    }
}
