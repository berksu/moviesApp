//
//  LoginPageViewModel.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import Combine
import SwiftUI

final class LoginPageViewModel: ObservableObject{
    
    @Published var mail = ""
    @Published var password = ""

    @Published var isSignInTapped = false
    @Published var isForgotPasswordTapped = false

    @Published var signInEmail = ""
    @Published var signInPassword = ""
    @Published var signInPasswordRepeat = ""
    @Published var isValidEmail = false
    @Published var isPasswordEqual = true
    
    @Published var isLoggedIn: Bool = false
    @Published var isSignedIn: Bool = false

    var cancellables = Set<AnyCancellable>()
    
    func controlIsSignedIn() {
        isSignedIn = AuthenticationApi().controlUserIsSignedIn()
    }

    init(){
        userNameControl()
    }
    
    func userNameControl(){
        $signInEmail
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{keyword in
                //self.searchMovies(title: self.searchMovie)
                if keyword.contains("@") {
                    print("exists")
                    return true
                }else{
                    return false
                }
            }
            .assign(to: \.isValidEmail, on: self)
            .store(in: &cancellables)
    }
    
    func signInButtonUpdate(state: Bool){
        isSignInTapped = state
    }
    
    func login(){
        AuthenticationApi().login(mail: mail, password: password) { isIn in
            //completion(isLoggedIn)
            self.isLoggedIn = isIn
        }
    }
    
    func signIn(completion: @escaping (Bool) -> Void){
        if(signInPassword == signInPasswordRepeat){
            AuthenticationApi().signIn(signInEmail: signInEmail, signInPassword: signInPassword, signInPasswordRepeat: signInPasswordRepeat) { success in
                completion(success)
            }
        }else{
            isSignInTapped = true
            completion(false)
            isPasswordEqual = false
        }
    }
    
    func forgotPasswordUpdate(state: Bool){
        isForgotPasswordTapped = state
    }
}
