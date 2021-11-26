//
//  SideMenuView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 16.11.2021.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @Binding var isSideMenuShow: Bool
    let sideMenuModel = SideMenuModel()
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            
            VStack(alignment: .leading){
                HStack{
                    KFImage(URL(string: sideMenuModel.url))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .shadow(radius: 20)
                        .overlay(Circle().stroke(.white ,lineWidth: 2))
                        .frame(height: 100)
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.spring()){
                            isSideMenuShow.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }.scaledToFit()
                    
                }
                
                userInfo(sideMenuModel: sideMenuModel)
                Spacer()
            }
            .ignoresSafeArea()
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
            Spacer()
            
        }.navigationBarHidden(true)
        
    }
}


struct userInfo: View{
    @ObservedObject var sideMenuViewModel = SideMenuViewModell()
    @State var isSignedOut: Bool=false
    let sideMenuModel: SideMenuModel

    var body: some View{
        VStack(alignment: .leading){
            Text(sideMenuModel.name)
                .font(.system(size:24, weight: .semibold))
            Text(sideMenuModel.hashtag)
                .font(.system(size:14))
            
            
            HStack{
                Text(sideMenuModel.follower)
                    .font(.system(size:16, weight: .bold))
                Text("Follower")
                    .font(.system(size:16, weight:.semibold))
            }.padding(.top)
            .padding(.bottom)
            
            
            ForEach(SideMenuViewModel.allCases, id: \.self){option in
                if(option.title != SideMenuViewModel.profile.title){
                    NavigationLink(destination: LoginPageView(), isActive: $isSignedOut) {
                        sideMenuButtons(viewModel: option)
                            .padding(.top)
                            .onTapGesture {
                                isSignedOut = sideMenuViewModel.logout()
                            }
                    }
                    //NavigationLink(destination: LoginPageView()) {
                    //    sideMenuButtons(viewModel: option)
                    //        .padding(.top)
                    //}
                }else{
                    NavigationLink(destination: CardMenuView(cardMenuViewModel: CardMenuViewModel())) {
                        sideMenuButtons(viewModel: option)
                            .padding(.top)
                    }
                }
                
            }
            
            
        }.foregroundColor(.white)
    }
}


struct sideMenuButtons: View{
    let viewModel: SideMenuViewModel
        
    var body: some View{
        HStack{
            Image(systemName: viewModel.imageName)
                .font(.system(size:16, weight:.semibold))
            Text(viewModel.title)
                .font(.system(size:16, weight: .bold))
        }
    }
}


struct logoutButton: View{
    var body: some View{
        HStack{
            Image(systemName: "chevron.backward.square")
                .font(.system(size:16, weight:.semibold))
            Text("Logout")
                .font(.system(size:16, weight: .bold))
        }
    }
}


struct SideMenuView_Previews: PreviewProvider {
    @State static var isSideMenu: Bool = false
    static var previews: some View {
        SideMenuView(isSideMenuShow: $isSideMenu)
    }
}
