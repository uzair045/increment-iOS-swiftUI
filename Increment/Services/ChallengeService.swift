//
//  ChallengeService.swift
//  Increment
//
//  Created by Uzair Mughal on 06/09/2021.
//

import Combine
import FirebaseFirestore

protocol ChallengeServiceProtocol {
    func create(_ challenge: ChallengeModel) -> AnyPublisher<Void, IncrementError>
    func observeChallenges(userId: UserId) -> AnyPublisher<[ChallengeModel], IncrementError>
}

final class ChallengeService: ChallengeServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func create(_ challenge: ChallengeModel) -> AnyPublisher<Void, IncrementError> {
        return Future<Void, IncrementError> { promise in
            do {
                _ = try self.db.collection("challanges").addDocument(data: challenge.asDictionary()) { error in
                    
                    if let error = error {
                        promise(.failure(.default(description: error.localizedDescription)))
                        return
                    }
                    
                    promise(.success(()))
                }
            } catch {
                promise(.failure(.default()))
            }
        }.eraseToAnyPublisher()
    }
    
    func observeChallenges(userId: UserId) -> AnyPublisher<[ChallengeModel], IncrementError> {
        let query = self.db.collection("challanges").whereField("userId", isEqualTo: userId)
        return Publishers.QuerySnapshotPublisher(query: query)
            .flatMap { snapshot -> AnyPublisher<[ChallengeModel], IncrementError> in
                do {
                    let challenges = try snapshot.documents.compactMap {
                        try $0.data(as: ChallengeModel.self)
                    }

                    return Just(challenges) 
                        .setFailureType(to: IncrementError.self)
                        .eraseToAnyPublisher()
                } catch {
                    return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
                }

            }.eraseToAnyPublisher()
    }
}
