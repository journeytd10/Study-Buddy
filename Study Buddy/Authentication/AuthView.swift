  //
//  AuthView.swift
//  Study Buddy
//
//  Created by Journey Galore on 8/24/23.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text(" Study Buddy")
            
            Textfield("Email", text:$viewModel.emailText)
            SecureField("Password", text: $viewModel.passwordText)
            
            Button {
                viewModel.authenticate()
            } label: {
                Text("Login")
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
