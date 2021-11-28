//
//  ProfileInfoView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 27.11.2021.
//

import SwiftUI
import Kingfisher

struct ProfileInfoView: View {
    
    @State var profileInfo = SideMenuModel()
    
    var body: some View {
        GeometryReader{geometry in
            VStack{
                imageView
                    .padding(.top,30)
                userInfoView
                Spacer()
            }
        }
        .padding(.top,70)
        .ignoresSafeArea()
    }
    
    
    
    var imageView:some View{
        Button {
            print("Image change")
        } label: {
            KFImage(URL(string: profileInfo.url))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .shadow(radius: 20)
                .overlay(Circle().stroke(.white ,lineWidth: 2))
                .frame(height: 200)
        }
    }
    
    
    var userInfoView: some View{
        GeometryReader{geometry in
            VStack{
                HStack{
                    Text("Name")
                        .font(.system(size:16, weight: .medium))
                        .foregroundColor(Color(.black))
                        .cornerRadius(16)
                        .frame(width: geometry.size.width*0.2)
                        .padding()
                    
                    TextField("Username", text: $profileInfo.name)
                        .frame(width: geometry.size.width*0.5)
                        .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(.black)))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
                
                HStack{
                    Spacer()
                    Text("Hashtag")
                        .font(.system(size:16, weight: .medium))
                        .foregroundColor(Color(.black))
                        .cornerRadius(16)
                        .frame(width: geometry.size.width*0.2)
                        .padding()
                    
                    TextField("Hashtag", text: $profileInfo.hashtag)
                        .frame(width: geometry.size.width*0.5)
                        .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(.black)))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Text("Follower")
                        .font(.system(size:16, weight: .medium))
                        .foregroundColor(Color(.black))
                        .cornerRadius(16)
                        .frame(width: geometry.size.width*0.2)
                        .padding()
                    
                    TextField("Follower", text: $profileInfo.follower)
                        .frame(width: geometry.size.width*0.5)
                        .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(.black)))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    Spacer()
                    
                }
                
                saveButton
                    .padding(.top)
            }
        }
    }
    
    
    
    
    var saveButton: some View{
        Text("Save")
            .modifier(ButtonViewCustomRoundedStyle(buttonColor: Color(.blue)))
            .onTapGesture {
                print("asd")
            }
    }
    
    
}



struct ProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoView()
    }
}
