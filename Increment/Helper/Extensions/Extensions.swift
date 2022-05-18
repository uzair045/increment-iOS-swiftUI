//
//  Extensions.swift
//  Increment
//
//  Created by Uzair Mughal on 07/09/2021.
//

import Foundation
import FirebaseFirestore


extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}


extension QueryDocumentSnapshot {
    func data<T: Codable>(as model: T.Type) throws -> T {
        do {
            let data = try JSONSerialization.data(withJSONObject: self.data(), options: .fragmentsAllowed)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NSError()
        }
    }
}
