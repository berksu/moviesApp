//
//  SignIn.swift
//  movie
//
//  Created by Berksu Kısmet on 21.11.2021.
//

import SwiftUI

struct SignIn: View {
    @ObservedObject var viewModel: LoginPageViewModel
    @State var name: String = ""
    @State var lastName: String = ""
    
    var body: some View {
        GeometryReader{geometry in
            NavigationView{
                ZStack{
                    Color.black
                        .ignoresSafeArea()
                    
                    VStack{
                        userImage(geometry: geometry)
                            .padding(.top, geometry.safeAreaInsets.top + 20)
                        addImageText
                            .padding(.top,5)
                        Group{
                            infoTexts(text: "FIRST NAME", geometry: geometry)
                                .padding(.top,5)
                            nameInputField(placeholder: "first name", geometry: geometry)
                        }
                        
                        Group{
                            infoTexts(text: "LAST NAME", geometry: geometry)
                                .padding(.top,5)
                            lastnameInputField(placeholder: "last name", geometry: geometry)
                        }
                        Group{
                            infoTexts(text: "EMAIL", geometry: geometry)
                                .padding(.top,5)
                            emailInputField(placeholder: "email", geometry: geometry)
                        }
                        
                        Group{
                            infoTexts(text: "PASSWORD", geometry: geometry)
                                .padding(.top,5)
                            passwordInputField(placeholder: "password", geometry: geometry)
                        }
                        
                        Group{
                            infoTexts(text: "CONFIRM", geometry: geometry)
                                .padding(.top,5)
                            passwordRepeatInputField(placeholder: "confirm password", geometry: geometry)
                        }
                        
                        signInButton(geometry: geometry)
                            .padding()
                        
                        Spacer()
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
    
    
    
    
    func signInButton(geometry: GeometryProxy) -> some View{
        return Text("REGISTER")
            .modifier(LoginPageButtonField())
            .frame(width: geometry.size.width * 0.78)
            .onTapGesture {
                viewModel.signIn { isIn in
                    viewModel.signInButtonUpdate(state: isIn ? false:true)
                }
            }
    }
    
    
    func userImage(geometry: GeometryProxy) -> some View{
        return ZStack{
            Circle()
                .foregroundColor(Color(red: 29/255, green: 29/255, blue: 29/255))
            Image("user2")
                .resizable()
                .frame(width: geometry.size.width * 0.13, height: geometry.size.width * 0.15)
        }.frame(width: geometry.size.width * 0.26, height: geometry.size.width * 0.26)
        
    }
    
    var addImageText: some View{
        Text("Add profile picute")
            .font(.system(size:15, weight: .medium))
            .foregroundColor(.white)
    }
    
    func infoTexts(text: String, geometry: GeometryProxy) -> some View{
        return HStack{
            Text(text)
            .font(.system(size:12, weight: .bold))
            .foregroundColor(.white)
            
            Spacer()
        }.padding(.leading,geometry.size.width * 0.11)
    }
    
    func nameInputField(placeholder: String, geometry: GeometryProxy) -> some View{
        return TextField("", text: $name)
            .modifier(PlaceholderStyle(showPlaceHolder: name.isEmpty,
                                   placeholder: placeholder))
            .modifier(LoginPageTextField())
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .frame(width: geometry.size.width * 0.78)
    }
    
    func lastnameInputField(placeholder: String, geometry: GeometryProxy) -> some View{
        return TextField("", text: $lastName)
            .modifier(PlaceholderStyle(showPlaceHolder: lastName.isEmpty,
                                   placeholder: placeholder))
            .modifier(LoginPageTextField())
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .frame(width: geometry.size.width * 0.78)
    }
    
    func emailInputField(placeholder: String, geometry: GeometryProxy) -> some View{
        return TextField("", text: $viewModel.signInEmail)
            .modifier(PlaceholderStyle(showPlaceHolder: viewModel.signInEmail.isEmpty,
                                   placeholder: placeholder))
            .modifier(LoginPageTextField())
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .frame(width: geometry.size.width * 0.78)
    }
    
    func passwordInputField(placeholder: String, geometry: GeometryProxy) -> some View{
        return SecureField("", text: $viewModel.signInPassword)
            .modifier(PlaceholderStyle(showPlaceHolder: viewModel.signInPassword.isEmpty,
                                   placeholder: placeholder))
            .modifier(LoginPageTextField())
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .frame(width: geometry.size.width * 0.78)
    }
    
    func passwordRepeatInputField(placeholder: String, geometry: GeometryProxy) -> some View{
        return SecureField("", text: $viewModel.signInPasswordRepeat)
            .modifier(PlaceholderStyle(showPlaceHolder: viewModel.signInPasswordRepeat.isEmpty,
                                   placeholder: placeholder))
            .modifier(LoginPageTextField())
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .frame(width: geometry.size.width * 0.78)
    }
    
    
}



struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(viewModel: LoginPageViewModel())
    }
}
