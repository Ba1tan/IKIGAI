//
//  RegisterView.swift
//  IKIGAI
//
//  Created by Anuar Sultanbekov on 10.02.2025.
//

import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var registrationMessage: String?
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let message = registrationMessage {
                Text(message)
                    .foregroundColor(message.contains("success") ? .green : .red)
                    .padding()
            }

            Button(action: {
                if password == confirmPassword {
                    let success = authViewModel.register(username: username, password: password)
                    registrationMessage = success ? "Registration successful!" : authViewModel.errorMessage
                    if success {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                } else {
                    registrationMessage = "Passwords do not match"
                }
            }) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .disabled(username.isEmpty || password.isEmpty || confirmPassword.isEmpty)

            Spacer()
        }
        .padding()
    }
}
