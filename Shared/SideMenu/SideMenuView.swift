//
//  SideMenuView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 16.11.2021.
//

import SwiftUI
import Kingfisher
import simd

struct SideMenuView: View {
    @Binding var isSideMenuShow: Bool
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            
            VStack(alignment: .leading){
                HStack{
                    KFImage(URL(string: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"))
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
                
                userInfo()
                Spacer()
            }
            .ignoresSafeArea()
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
            Spacer()
            
        }.navigationBarHidden(true)
        
    }
}


struct userInfo: View{
    var body: some View{
        VStack(alignment: .leading){
            Text("Eddie Brook")
                .font(.system(size:24, weight: .semibold))
            Text("@eddie")
                .font(.system(size:14))
            
            
            HStack{
                Text("3425")
                    .font(.system(size:16, weight: .bold))
                Text("Follower")
                    .font(.system(size:16, weight:.semibold))
            }.padding(.top)
            .padding(.bottom)
            
            
            ForEach(SideMenuViewModel.allCases, id: \.self){option in
                sideMenuButtons(viewModel: option)
                    .padding(.top)
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
