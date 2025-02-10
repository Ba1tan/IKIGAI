//
//  LoginView.swift
//  IKIGAI
//
//  Created by Anuar Sultanbekov on 10.02.2025.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text("IKIGAI Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if let errorMessage = authViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Button(action: {
                    authViewModel.login(username: username, password: password)
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink("Don't have an account? Register", destination: RegisterView())
                    .padding()

                Spacer()
            }
            .padding()
        }
    }
}
