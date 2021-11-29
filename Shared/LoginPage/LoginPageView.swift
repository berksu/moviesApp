//
//  ContentView.swift
//  Shared
//
//  Created by Berksu Kısmet on 10.11.2021.
//

import SwiftUI

struct LoginPageView: View {
    @ObservedObject var viewModel = LoginPageViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: MoviesListView(),isActive: $viewModel.isSignedIn) {
                    EmptyView()
                }
                
                inputFieldView
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $viewModel.isSignInTapped, onDismiss: {
            viewModel.signInButtonUpdate(state: false)
            viewModel.controlIsSignedIn()
        }, content: {
            SignIn(viewModel: viewModel)
        })
    }
    
    // MARK: - UI Components
    
    private var inputFieldView: some View {
        VStack {
            Image("login_icon")
                .resizable()
                .frame(width: UIScreen.main.bounds.width / 1.8, height: UIScreen.main.bounds.height / 3.5)
                .padding(.top, -100)
            userNameField
                .padding(.top, 60)
            passwordField
            
            HStack(alignment: .center, spacing: -20){
                loginButton
                signUpButton
            }
            .padding()
        }
    }
    
    var userNameField: some View {
        TextField("Username", text: $viewModel.mail)
            .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(.black)))
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
    
    var passwordField: some View {
        SecureField("Password", text: $viewModel.password)
            .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(.black)))
    }
    
    var loginButton: some View {
        NavigationLink(destination: MoviesListView(),isActive: $viewModel.isLoggedIn) {
            Text("Login")
                .modifier(ButtonViewCustomRoundedStyle(buttonColor: Color(.red)))
                .onTapGesture {
                    viewModel.login()
                }
        }
    }
    
    var signUpButton: some View {
        Text("Sign In")
            .modifier(ButtonViewCustomRoundedStyle(buttonColor: Color(.red)))
            .onTapGesture {
                withAnimation(.spring()) {
                    viewModel.signInButtonUpdate(state: true)
                }
            }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView(viewModel: .init())
    }
}
