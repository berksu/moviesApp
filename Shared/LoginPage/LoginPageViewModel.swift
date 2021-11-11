//
//  LoginPageViewModel.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import Foundation

final class LoginPageViewModel: ObservableObject{
    
    @Published var userName = ""
    @Published var password = ""
}
