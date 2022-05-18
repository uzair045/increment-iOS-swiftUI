//
//  ChallengeItemVM.swift
//  Increment
//
//  Created by Uzair Mughal on 13/09/2021.
//

import Foundation

struct ChallengeItemVM: Hashable {
    private let challenge: ChallengeModel
    
    var title: String {
        challenge.exercise.capitalized
    }
    
    private var daysFromStart: Int {
        guard let daysFromStart = Calendar.current.dateComponents([.day], from: challenge.startDate, to: Date()).day else {
            return 0
        }
        return abs(daysFromStart)
    }
    
    private var isComplete: Bool {
        challenge.lenght - (daysFromStart + 1) <= 0
    }
    
    var statusText: String {
        guard !isComplete else {
            return "Done"
        }
        return "Day \(daysFromStart + 1) of \(challenge.lenght)"
    }
    
    var dailyIncreaseText: String {
        "+\(challenge.increase) daily"
    }
    
    init(_ challenge: ChallengeModel) {
        self.challenge = challenge
    }
}
