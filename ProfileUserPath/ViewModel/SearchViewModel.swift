//
//  SearchViewModel.swift
//  meetmeoutside
//
//  Created by Matthew Molinar on 11/29/22.
//

import Foundation
import Firebase

import SwiftUI



enum SearchViewModelConfiguration {
    case search
    case newMessage
}

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    private let config: SearchViewModelConfiguration
    
    init(config: SearchViewModelConfiguration) {
        self.config = config
        fetchUsers(forConfig: config)
    }
    
    func fetchUsers(forConfig config: SearchViewModelConfiguration) {
        Firestore.firestore().collection("users").getDocuments(completion: { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let users = documents.map({ User(dictionary: $0.data()) })
            
            switch config {
            case .newMessage:
                self.users = users.filter({ !$0.isCurrentUser })
            case .search:
                self.users = users
            }
            
            
//            print("DEBUG: Users \(users)")
            
//            documents.forEach { document in
//                let user = User(dictionary: document.data())
//                self.users.append(user)
//            }
        })
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.name.lowercased().contains(lowercasedQuery) || $0.username.contains(lowercasedQuery)})
    }
}
