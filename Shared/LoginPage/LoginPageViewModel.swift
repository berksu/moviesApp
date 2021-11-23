//
//  LoginPageViewModel.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import Foundation
import Combine

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
}
