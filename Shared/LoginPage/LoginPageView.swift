//
//  ContentView.swift
//  Shared
//
//  Created by Berksu Kısmet on 10.11.2021.
//

import SwiftUI
import Firebase

struct LoginPageView: View {
    @ObservedObject var viewModel = LoginPageViewModel()
    @State private var offset = CGSize.zero


    var body: some View {
            NavigationView {
    //            ZStack{
    //                loginPageViewBack(viewModel: viewModel)
    //                if(viewModel.isSignInTapped){
    //                    SignIn()
    //                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    //                        .cornerRadius(60.0)
    //                        .transition(.move(edge: .bottom))
    //                        .offset(x: 0 , y: offset.height)
    //                        .gesture(
    //                            DragGesture()
    //                                .onChanged{ gesture in
    //                                    if(gesture.translation.height > 0){
    //                                        self.offset = gesture.translation
    //                                    }
    //                                }
    //                                .onEnded{ _ in
    //                                    if(self.offset.height > 100){
    //                                        withAnimation{
    //                                            self.viewModel.isSignInTapped.toggle()
    //                                            self.offset = CGSize.zero
    //                                        }
    //                                    }else{
    //
    //                                    }
    //                                }
    //                        )
    //
    //                }
    //
    //            }
                loginPageViewBack(viewModel: viewModel)
            }.onAppear(perform: authenticationProcess)
                .sheet(isPresented: $viewModel.isSignInTapped, onDismiss: {
                    viewModel.isSignInTapped = false
                }, content: {
                    SignIn()
                })
        }
    
    
    
    private func authenticationProcess(){
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else{return }
            let _ = user.isAnonymous
            let _ = user.uid
        }
    }
}







struct loginPageViewBack: View{
    @State var viewModel: LoginPageViewModel
    
    var userNameField: some View{
        TextField("Username", text: $viewModel.mail)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    var passwordField: some View{
        SecureField("Password", text: $viewModel.password)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    
    var loginButton: some View{
        NavigationLink(destination: MoviesListView()) {
            Text("Login")
                .modifier(ButtonViewCustomRoundedStyle())
        }
    }
    
    
    var signUpButton: some View{
        //NavigationLink(destination: MoviesListView()) {
            Text("Sign In")
                .modifier(ButtonViewCustomRoundedStyle())
                .onTapGesture {
                    withAnimation(.spring()){
                        viewModel.isSignInTapped.toggle()
                    }
                }
        //}
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
