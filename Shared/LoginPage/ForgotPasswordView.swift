//
//  ForgotPasswordView.swift
//  movie
//
//  Created by Berksu Kısmet on 9.12.2021.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @ObservedObject var forgotPasswordViewModel = ForgotPasswordViewModel()
    
    var body: some View {
        GeometryReader{geometry in
            VStack{
                logo(geometry: geometry)
                    .padding(.top, 100)
                
                Text("FORGOT PASSWORD ?")
                    .foregroundColor(.white)
                    .font(.system(size:13, weight: .bold))
                    .padding()
                
                Text("Enter the email address you used to create your account and we will email you a link to reset your password")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .font(.system(size:13, weight: .medium))
                    .frame(width: geometry.size.width * 0.66)
                    .padding(.bottom)
                    
                
                Group{
                    infoTexts(text: "EMAIL", geometry: geometry)
                        .padding(.top)
                    emailInputField(placeholder: "email", geometry: geometry)
                }
                
                senEmailButton(geometry: geometry)
                    .padding()
            }
        }.background(.black)
    }
    
    func logo(geometry: GeometryProxy) -> some View{
        return HStack{
                Spacer()
                Image("logo")
                    .frame(width: geometry.size.width * 0.28, height: geometry.size.height * 0.15, alignment: .center)
                Spacer()
            }
    }
    
    func infoTexts(text: String, geometry: GeometryProxy) -> some View{
        return HStack{
            Text(text)
            .font(.system(size:12, weight: .bold))
            .foregroundColor(.white)
            
            Spacer()
        }.padding(.leading,geometry.size.width * 0.11)
    }
    
    func emailInputField(placeholder: String, geometry: GeometryProxy) -> some View{
        return TextField("", text: $forgotPasswordViewModel.email)
            .modifier(PlaceholderStyle(showPlaceHolder: forgotPasswordViewModel.email.isEmpty,
                                   placeholder: placeholder))
            .modifier(LoginPageTextField())
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .frame(width: geometry.size.width * 0.78, height: 40)
    }
    
    func senEmailButton(geometry: GeometryProxy) -> some View{
        return Text("SEND EMAIL")
            .modifier(LoginPageButtonField())
            .frame(width: geometry.size.width * 0.78)
            .onTapGesture {
                //
            }
    }
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
