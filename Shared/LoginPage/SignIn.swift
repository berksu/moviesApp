//
//  SignIn.swift
//  movie
//
//  Created by Berksu Kısmet on 21.11.2021.
//

import SwiftUI

struct SignIn: View {
    
    @ObservedObject var viewModel = LoginPageViewModel()

    var emailField: some View{
        TextField("Username", text: $viewModel.signInEmail)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    var passwordField: some View{
        SecureField("Password", text: $viewModel.signInPassword)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    var passwordRepatField: some View{
        SecureField("Re-Type Password", text: $viewModel.signInPasswordRepeat)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    
    var signInButton: some View{
        NavigationLink(destination: MoviesListView()) {
            Text("Sign In")
                .modifier(ButtonViewCustomRoundedStyle())
        }
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.orange, .green]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack{
                Image("login_icon")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/1.8, height: UIScreen.main.bounds.height/3.5)
                    .padding(.top,-100)
                emailField
                    .padding(.top, 60)
                passwordField
                passwordRepatField
                signInButton.padding(.top)
            }
        }
        
        
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
