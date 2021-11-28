//
//  ContentView.swift
//  Shared
//
//  Created by Berksu Kısmet on 10.11.2021.
//

import SwiftUI

struct LoginPageView: View {
    @ObservedObject var viewModel = LoginPageViewModel()
    @State private var offset = CGSize.zero
    @State private var isSignedIn: Bool = false

    var body: some View {
            NavigationView {
                ZStack{
                    NavigationLink(destination: MoviesListView(),isActive: $isSignedIn) {
                        EmptyView()
                    }
                    loginPageViewBack(viewModel: viewModel)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $viewModel.isSignInTapped, onDismiss: {
                viewModel.signInButtonUpdate(state: false)
                isSignedIn = viewModel.isSignedIn()
            }, content: {
                SignIn(viewModel: viewModel)
            })
        }
}



struct loginPageViewBack: View{
    @State var viewModel: LoginPageViewModel
    
    var userNameField: some View{
        TextField("Username", text: $viewModel.mail)
            .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(.black)))
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
    
    var passwordField: some View{
        SecureField("Password", text: $viewModel.password)
            .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(.black)))
    }
    
    
    //Indicator will add
    @State var isLoggedIn:Bool = false
    var loginButton: some View{
        NavigationLink(destination: MoviesListView(),isActive: $isLoggedIn) {
            Text("Login")
                .modifier(ButtonViewCustomRoundedStyle(buttonColor: Color(.red)))
                .onTapGesture {
                    viewModel.login { isIn in
                        isLoggedIn = isIn ? true:false
                    }
                }
        }
    }
    
    
    var signUpButton: some View{
            Text("Sign In")
                .modifier(ButtonViewCustomRoundedStyle(buttonColor: Color(.red)))
                .onTapGesture {
                    withAnimation(.spring()){
                        viewModel.signInButtonUpdate(state: true)
                    }
                }
    }
    
    var body: some View{
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


struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView(viewModel: .init())
    }
}
