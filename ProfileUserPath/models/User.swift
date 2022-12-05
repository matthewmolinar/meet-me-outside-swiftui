//
//  User.swift
//  ProfileUserPath
//
//  Created by Amber Etana Vasquez on 11/19/22.
//

import Foundation

struct User: Identifiable {
    let id: String
    
    let name: String
    let username: String
    let age: String
    let grade: String
    let profilePictureUrl: String
    let profileDescription: String
    
    
    
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.age = dictionary["age"] as? String ?? ""
        self.grade = dictionary["grade"] as? String ?? ""
        self.profilePictureUrl = dictionary["profilePictureUrl"] as? String ?? ""
        self.profileDescription = dictionary["profileDescription"] as? String ?? ""
        
    }
}
