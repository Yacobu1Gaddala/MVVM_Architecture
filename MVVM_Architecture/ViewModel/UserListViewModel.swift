//
//  UserListViewModel.swift
//  MVVM_Architecture
//
//  Created by G Yacobu on 08/08/25.
//

import SwiftUI


class UserListViewModel: ObservableObject {
    
    
    @Published var users: [User] = []
    
    
    init() {
       fetchUsers()
    }
    
    
    // Fetch users
    
    func fetchUsers() {
        
        let dummyUsers = [
            User(id: 1, name: "John Doe", email: "john@example.com"),
            User(id: 2, name: "Jane Smith", email: "jane@example.com")
        ]
        
        self.users = dummyUsers
    }
}
