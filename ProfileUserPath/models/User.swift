//
//  User.swift
//  ProfileUserPath
//
//  Created by Amber Etana Vasquez on 11/19/22.
//

import Foundation

public struct User: Codable {
    let name: String
    let age: String
    let grade: String
    let profilePicture: String
    let profileDescription: String
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case age
        case grade
        case profilePicture
        case profileDescription
    }
    
    var dictionary: [String: Any] {
         let data = (try? JSONEncoder().encode(self)) ?? Data()
         return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
     }
}
