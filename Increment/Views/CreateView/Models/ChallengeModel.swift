//
//  ChallengeModel.swift
//  Increment
//
//  Created by Uzair Mughal on 06/09/2021.
//

import Foundation

struct ChallengeModel: Codable, Hashable {
    let exercise: String
    let startAmount: Int
    let increase: Int
    let lenght: Int
    let userId: String
    let startDate: Date
    
    enum CodingKeys: String, CodingKey {
        case exercise
        case startAmount
        case increase
        case lenght
        case userId
        case startDate
    }
}
