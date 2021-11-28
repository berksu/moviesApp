//
//  SignIn.swift
//  movie
//
//  Created by Berksu Kısmet on 21.11.2021.
//

import SwiftUI

struct SignIn: View {
    @ObservedObject var viewModel: LoginPageViewModel
    
    var emailField: some View{
        TextField("E-mail", text: $viewModel.signInEmail)
            .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(.black)))
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
    
    var passwordField: some View{
        SecureField("Password", text: $viewModel.signInPassword)
            .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(viewModel.isPasswordEqual ? .black: .red)))
    }
    
    var passwordRepatField: some View{
        SecureField("Re-Type Password", text: $viewModel.signInPasswordRepeat)
            .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(viewModel.isPasswordEqual ? .black: .red)))
    }
    
    
    var signInButton: some View{
        Text("Sign In")
            .modifier(ButtonViewCustomRoundedStyle(buttonColor: Color(.red)))
            .onTapGesture {
                viewModel.signIn { isIn in
                    viewModel.signInButtonUpdate(state: isIn ? false:true)
                }
            }
        
    }
    
    var closePageButton: some View{
        Button {
            viewModel.signInButtonUpdate(state: false)
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
                    }.padding(.bottom)
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
        SignIn(viewModel: LoginPageViewModel())
    }
}
