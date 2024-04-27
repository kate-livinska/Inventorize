//
//  LoginView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginVM = LoginViewModel()
    @State private var isEmailValid = true
    
    var body: some View {
        VStack {
            Text("Login.Title".localized)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            VStack {
                Text("Login.UsernameField.Title".localized)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                TextField("Login.UsernameField.Title".localized, text: $loginVM.username, onEditingChanged: { (isChanged) in
                    if !isChanged {
                        if self.textFieldValidatorEmail(loginVM.username) {
                            self.isEmailValid = true
                        } else {
                            self.isEmailValid = false
                            loginVM.username = ""
                        }
                    }
                })
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                if !self.isEmailValid {
                    Text("Email is not valid.")
                        .font(.callout)
                        .foregroundColor(Color.red)
                }
            }.padding()
            
            VStack {
                Text("Login.PasswordField.Title".localized)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
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
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(.bordered)
            .padding()
        }
    }
    
    func textFieldValidatorEmail(_ string: String) -> Bool {
            if string.count > 100 {
                return false
            }
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            return emailPredicate.evaluate(with: string)
        }
}

#Preview {
    LoginView()
}
