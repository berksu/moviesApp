//
//  ContentView.swift
//  Shared
//
//  Created by Berksu Kısmet on 10.11.2021.
//

import SwiftUI

struct LoginPage: View {
    @ObservedObject var viewModel = LoginPageViewModel()
    
    var userNameField: some View{
        TextField("Username", text: $viewModel.mail)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    var passwordField: some View{
        SecureField("Password", text: $viewModel.password)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    
    var loginButton: some View{
        NavigationLink(destination: moviesView()) {
            Text("Login")
                .modifier(ButtonViewCustomRoundedStyle())
        }
    }
    
    
    var signUpButton: some View{
        NavigationLink(destination: moviesView()) {
            Text("Sign In")
                .modifier(ButtonViewCustomRoundedStyle())
        }
    }
    
    
    
    var body: some View {
        NavigationView {
        VStack{
            Image("login_icon")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/1.8, height: UIScreen.main.bounds.height/3.5)
                .padding(.top,-100)
            userNameField
                .padding(.top, 60)
            passwordField

            HStack(alignment: .center, spacing: -20){
                loginButton
                signUpButton
            }.padding()
            
            }
        
    }
    }
}










struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(viewModel: .init())
    }
}
