//
//  SignIn.swift
//  movie
//
//  Created by Berksu Kısmet on 21.11.2021.
//

import SwiftUI

struct SignIn: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel = LoginPageViewModel()

    var emailField: some View{
        TextField("E-mail", text: $viewModel.signInEmail)
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
        Button {
            isPresented = false
        } label: {
            Text("Sign In")
                .modifier(ButtonViewCustomRoundedStyle())
//                .onTapGesture {
//                    viewModel.signIn { isSignedIn in
//                        NavigationLink(destination: MoviesListView(), isActive: isSignedIn) {
//                            EmptyView()
//                        }
//                    }
//                }
            
        }

    }
    
    var closePageButton: some View{
        Button {
            isPresented = false
        } label: {
           Image(systemName: "xmark.circle")
                .resizable()
                .foregroundColor(.red)
                .font(.system(size: 10, weight: .bold))
                .frame(width: 20, height: 20)
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.orange, .green]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                        Spacer()
                        closePageButton
                            .padding(.trailing)
                    }
                    Image("login_icon")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/1.8, height: UIScreen.main.bounds.height/3.5)
                    
                    emailField
                        .padding(.top, 60)
                    passwordField
                    passwordRepatField
                    signInButton.padding(.top)
                    
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(isPresented:.constant(true))
    }
}
