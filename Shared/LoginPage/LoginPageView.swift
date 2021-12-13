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
                ZStack(alignment: .top){
                    GeometryReader{ geometry in

                        NavigationLink(destination: MainBackgroundView().navigationBarHidden(true),isActive: $viewModel.isSignedIn) {
                        EmptyView()
                    }
                    
                    backgroundImage(geometry: geometry)
                        .ignoresSafeArea()
                    
                    VStack{
                        logo(geometry: geometry)
                            .padding(.top, geometry.size.height * 0.13)
                        userNameField(geometry: geometry)
                            .padding(.top,geometry.size.height * 0.06)
                        passwordField(geometry: geometry)
                            .padding(.top,10)
                        loginButton(geometry: geometry)
                            .padding(.top)
                        
                        forgotPasswordButton()
                        
                        socialLoginsButton(geometry: geometry)
                            .padding(.top,geometry.size.height * 0.01)
                        
                        signUpButton
                            .padding(EdgeInsets(top: 25 , leading: 0, bottom: geometry.safeAreaInsets.bottom, trailing: 0))
                            //.padding(.bottom, geometry.safeAreaInsets.bottom)
                    }
                }.background(.black)
                .ignoresSafeArea()
            }
        }
        .navigationBarHidden(true)
        //signIn sheet
        .sheet(isPresented: $viewModel.isSignInTapped, onDismiss: {
            viewModel.signInButtonUpdate(state: false)
            viewModel.controlIsSignedIn()
        }, content: {
            SignIn(viewModel: viewModel)
        })
        //forgot password sheet
        .sheet(isPresented: $viewModel.isForgotPasswordTapped, onDismiss: {
            viewModel.forgotPasswordUpdate(state: false)
        }, content: {
            ForgotPasswordView()
        })
    }
    
    // MARK: - UI Components
    
    func backgroundImage(geometry: GeometryProxy) -> some View{
        return Image("image1")
                .frame(width: geometry.size.width, height: geometry.size.height*0.5)
                .opacity(0.77)
    }
    
    func logo(geometry: GeometryProxy) -> some View{
        return HStack{
                Spacer()
                Image("logo")
                    .frame(width: geometry.size.width * 0.28, height: geometry.size.height * 0.15, alignment: .center)
                Spacer()
            }
    }
    
    
    func userNameField(geometry: GeometryProxy) -> some View{
            return VStack{
                Text("Email")
                    .foregroundColor(.white)
                    .font(.system(size:12, weight: .bold))
                    .frame(width: geometry.size.width * 0.9, height: 20, alignment: .leading)
                
                TextField("", text: $viewModel.mail)
                    .modifier(PlaceholderStyle(showPlaceHolder: viewModel.mail.isEmpty,
                                           placeholder: "e-mail"))
                    .modifier(LoginPageTextField())
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .frame(width: geometry.size.width * 0.9)
            }
    }
    
    func passwordField(geometry: GeometryProxy) -> some View{
            return VStack{
                Text("Password")
                    .foregroundColor(.white)
                    .font(.system(size:12, weight: .bold))
                    .frame(width: geometry.size.width * 0.9, height: 20, alignment: .leading)
                
                SecureField("", text: $viewModel.password)
                    .modifier(PlaceholderStyle(showPlaceHolder: viewModel.password.isEmpty,
                                           placeholder: "password"))
                    .modifier(LoginPageTextField())
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .frame(width: geometry.size.width * 0.9)
            }
    }
    
    
    func loginButton(geometry: GeometryProxy) -> some View{
        return NavigationLink(destination: MainBackgroundView(),isActive: $viewModel.isLoggedIn) {
            Text("LOGIN")
                .modifier(LoginPageButtonField())
                .onTapGesture {
                    viewModel.login()
                }
                .frame(width: geometry.size.width * 0.9)
        }
    }
    
    func forgotPasswordButton() -> some View{
        return HStack{
            Spacer()
            
            Button {
                viewModel.forgotPasswordUpdate(state: true)
            } label: {
                Text("Forget Password ?")
                    .foregroundColor(.white)
                    .font(.system(size: 10, weight: .regular))
            }.padding(.trailing)
        }
    }
    
    func socialLoginsButton(geometry: GeometryProxy) -> some View{
        return Group{
            VStack{
                HStack{
                    line
                        .padding(.leading)
                    Text("Social Logins")
                        .font(.system(size:14, weight: .medium))
                        .foregroundColor(.white)
                        .padding()
                    line
                        .padding(.trailing)
                }
                
                HStack(spacing: 25){
                    Button {
                        //
                    } label: {
                        Image("facebookButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 43, height: 43)
                    }

                    Button {
                        //
                    } label: {
                        Image("googleButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 43, height: 43)
                    }
                }
            }
        }
    }
    
    var line: some View {
        VStack {
            Divider()
                .background(.white)
                .opacity(0.64)
        }
    }
    
    
    var signUpButton: some View {
        VStack(spacing: 5){
            Text("Don't have an account ?")
                .font(.system(size:14, weight: .medium))
                .foregroundColor(.white)
                .opacity(0.64)
            Text("REGISTER")
                .font(.system(size:14, weight: .bold))
                .foregroundColor(.white)
                .onTapGesture {
                    withAnimation(.spring()) {
                        viewModel.signInButtonUpdate(state: true)
                    }
                }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView(viewModel: .init())
    }
}
