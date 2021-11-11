//
//  ContentView.swift
//  Shared
//
//  Created by Berksu Kısmet on 10.11.2021.
//

import SwiftUI

struct LoginPage: View {
    //@ObservedObject var viewModel: LoginPageViewModel
    
    var body: some View {
        NavigationView {
        VStack{
            Image("login_icon")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/1.8, height: UIScreen.main.bounds.height/3.5)
                .padding(.top,-100)
            userNameView()
                .padding(.top, 60)
            passwordView()
            loginButton()
                .padding()
            //Spacer()
            
            }
        
    }
    }
}


struct userNameView: View{
    @State var mail = ""
    
    var body: some View{
        GeometryReader { geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 20.0).foregroundColor(.red).opacity(0.7)
                TextField("Username", text: self.$mail)
                    .padding()
                    .foregroundColor(.white)
            }.frame(width: geometry.size.width*0.9, height: 50, alignment: .center)
                .padding()
        }.frame(height:60)
    }
}


struct passwordView: View{
    @State var password = ""
    
    var body: some View{
        GeometryReader { geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 20.0).foregroundColor(.red).opacity(0.7)
                SecureField("Password", text: self.$password)
                    .padding()
                    .foregroundColor(.white)
            }.frame(width: geometry.size.width*0.9, height: 50, alignment: .center)
                .padding()
        }.frame(height:60)
    }
}


struct loginButton: View{
    var body: some View{
        GeometryReader { geometry in
            HStack{
                NavigationLink(destination: moviesView()) {
                    Text("Login")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .frame(width: geometry.size.width/2.5, height: 20)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.red, lineWidth: 4)
                        )
                }
                
                NavigationLink(destination: moviesView()) {
                    Text("Sign In")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .frame(width: geometry.size.width/2.5, height: 20)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.red, lineWidth: 4)
                        )
                }
            }
        }.frame(height: 50)
    }
}







struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
