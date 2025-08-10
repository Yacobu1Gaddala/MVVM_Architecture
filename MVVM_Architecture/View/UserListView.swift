//
//  UserListView.swift
//  MVVM_Architecture
//
//  Created by G Yacobu on 08/08/25.
//

import SwiftUI

struct UserListView: View {
    @State private var userName: String = ""
    @State private var email: String = ""
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
            
            VStack(spacing: 16) {
                TextField("Enter username", text: $userName)
                    .textInputAutocapitalization(.words)
                TextField("Enter emailID", text: $email)
                Button("Add User") {
                    userViewModel.addUsertoList(userName: userName, And: email)
                }
                
                .font(.subheadline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity,maxHeight: 30)
            }
            .background(Color.gray.opacity(0.5))
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)
            Spacer()
            
            
           
            .navigationTitle("Users")
        }
    }
}

#Preview {
    UserListView()
}
