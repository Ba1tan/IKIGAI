//
//  IKIGAIApp.swift
//  IKIGAI
//
//  Created by Nursultan Bukenbayev on 20.01.2025.
//

//import SwiftUI
//
//@main
//struct IKIGAIApp: App {
//    var body: some Scene {
//        WindowGroup {
//            MainMenuView()
//        }
//    }
//}
//
//


import SwiftUI

@main
struct IKIGAIApp: App {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                MainMenuView()
                    .environmentObject(authViewModel)
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
    }
}


