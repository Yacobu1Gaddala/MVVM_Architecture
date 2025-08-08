//
//  UserListView.swift
//  MVVM_Architecture
//
//  Created by G Yacobu on 08/08/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var userViewModel = UserListViewModel()
    
    var body: some View {
        NavigationStack {
            List(userViewModel.users) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                }
                
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    UserListView()
}
