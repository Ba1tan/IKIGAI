//
//  AuthViewModel.swift
//  IKIGAI
//
//  Created by Anuar Sultanbekov on 10.02.2025.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    @Published var currentUser: String?

    private let userKey = "registeredUsers"
    private let loggedInUserKey = "loggedInUser"

    init() {
        // Auto-login if user was already logged in
        if let savedUser = UserDefaults.standard.string(forKey: loggedInUserKey) {
            currentUser = savedUser
            isAuthenticated = true
        }
    }

    func register(username: String, password: String) -> Bool {
        var users = getRegisteredUsers()

        if users.contains(where: { $0.username == username }) {
            errorMessage = "Username already exists"
            return false
        }

        let newUser = User(username: username, password: password)
        users.append(newUser)
        saveUsers(users)
        return true
    }

    func login(username: String, password: String) {
        let users = getRegisteredUsers()

        if users.contains(where: { $0.username == username && $0.password == password }) {
            isAuthenticated = true
            currentUser = username
            errorMessage = nil
            UserDefaults.standard.set(username, forKey: loggedInUserKey)  // Save login state
        } else {
            errorMessage = "Invalid username or password"
        }
    }

    func logout() {
        isAuthenticated = false
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: loggedInUserKey)  // Remove login state
    }

    private func getRegisteredUsers() -> [User] {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            return users
        }
        return []
    }

    private func saveUsers(_ users: [User]) {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: userKey)
        }
    }
}
