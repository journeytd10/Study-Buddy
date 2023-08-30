//
//  AuthViewModel.swift
//  Study Buddy
//
//  Created by Journey Galore on 8/24/23.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    
    func authenticate() {
}
