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
    @State private var showImagePicker: Bool = false
    
    @State var image: Image?
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack{
            imageView
                .padding(.top,30)
            userInfoView
                .padding(.top)
            Spacer()
        }
        .padding(.top,70)
        .ignoresSafeArea()
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    var imageView:some View{
        Button {
            self.showImagePicker = true
        } label: {
            if image == nil{
                KFImage(URL(string: profileInfo.url))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .shadow(radius: 20)
                    .overlay(Circle().stroke(.white ,lineWidth: 2))
                    .frame(height: 150)
            }else{
                image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .shadow(radius: 20)
                    .overlay(Circle().stroke(.white ,lineWidth: 2))
                    .frame(height: 150)
            }
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
    
    func loadImage(){
        guard let inputImage = inputImage else{return}
        image = Image(uiImage: inputImage)
    }
}


struct ProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoView()
    }
}
