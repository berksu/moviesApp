//
//  LoginPageViewModel.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import Foundation
import Combine
import Firebase

final class LoginPageViewModel: ObservableObject{
    
    @Published var mail = ""
    @Published var password = ""

    @Published var isSignInTapped = false
    @Published var signInEmail = ""
    @Published var signInPassword = ""
    @Published var signInPasswordRepeat = ""
    @Published var isValidEmail = false

    var cancellables = Set<AnyCancellable>()

    init(){
        userNameControl()
    }
    
    
    func userNameControl(){
        $signInEmail
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink{keyword in
                //print("aaaaa")
                //self.searchMovies(title: self.searchMovie)
                if keyword.contains("@") {
                    print("exists")
                    self.isValidEmail = true
                }else{
                    self.isValidEmail = false
                }
            }
            .store(in: &cancellables)
    }
    
    
    func login(completion: @escaping (Bool) -> Void){
        print("Girdi")
        Auth.auth().signIn(withEmail: mail, password: password) { [weak self] authResult, error in
            guard let user = authResult?.user, error == nil else {
                // ...print("Signed in")
                completion(false)
                return
                
            }
            print("Logged In")
            completion(true)
            
        }
    }
    
    
    func signIn(completion: @escaping (Bool) -> Void){
        Auth.auth().createUser(withEmail: signInEmail, password: signInPassword) { authResult, error in
          // ...
            guard let user = authResult?.user, error == nil else {
                //strongSelf.showMessagePrompt(error!.localizedDescription)
                print("Login error: \(error)")
                completion(false)
                return
            }
            print("\(user.email!) created")
            completion(true)
        }
    }
    
}
