//
//  LoginView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginVM = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("Login.Title".localized)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            VStack {
                HStack {
                    Text("Login.UsernameField.Title".localized)
                    Spacer()
                }
                TextField("Login.UsernameField.Title".localized, text: $loginVM.username)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
            }.padding()
            
            
            VStack {
                HStack {
                    Text("Login.PasswordField.Title".localized)
                    Spacer()
                }
                SecureField(text: $loginVM.password, prompt: Text("Login.PasswordField.Prompt".localized)) {
                    Text("Login.PasswordField.Title".localized)
                }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
            }.padding()
            
            Button {
                loginVM.login()
            } label: {
                Text("Login.LoginButton.Title".localized)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(.bordered)
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
