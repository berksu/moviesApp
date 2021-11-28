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
        VStack{
            imageView
                .padding(.top,30)
            userInfoView
            Spacer()
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
                    Text("Username")
                        .modifier(ProfilePageCustomText(geometry: geometry))
                    
                    TextField("Username", text: $profileInfo.name)
                        .modifier(ProfilePageCustomTextField(geometry: geometry))
                }
                
                HStack{
                    Spacer()
                    Text("Hashtag")
                        .modifier(ProfilePageCustomText(geometry: geometry))
                    
                    TextField("Hashtag", text: $profileInfo.hashtag)
                        .modifier(ProfilePageCustomTextField(geometry: geometry))
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Text("Follower")
                        .modifier(ProfilePageCustomText(geometry: geometry))
                    
                    TextField("Follower", text: $profileInfo.follower)
                        .modifier(ProfilePageCustomTextField(geometry: geometry))
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
