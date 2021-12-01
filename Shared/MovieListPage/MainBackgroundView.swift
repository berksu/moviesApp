//
//  MoviesListView.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import SwiftUI
import Kingfisher

// 1 - TabBar - naming
struct MainBackgroundView: View {
    @ObservedObject var moviesViewModel = MainBackgroundViewModel()
    @State var isSideMenuShow: Bool = false
    
    var body: some View{
        NavigationView {
            ZStack{
                if(isSideMenuShow){
                    SideMenuView(isSideMenuShow: $isSideMenuShow)
                        
                }
                TabBackgroundView(moviesViewModel: moviesViewModel, isSideMenuShow: $isSideMenuShow)
                    .cornerRadius(isSideMenuShow ? 20 : 10)
                    .offset(x: isSideMenuShow ? 250:0, y: isSideMenuShow ? 50:0)
                    .scaleEffect(isSideMenuShow ? 0.8 : 1)
                    .opacity(isSideMenuShow ? 0.4:1)
                    .ignoresSafeArea(.container, edges: .bottom)
                    .disabled(isSideMenuShow)
            }
        }
        .navigationBarHidden(true)
            .searchable(text: $moviesViewModel.searchMovie, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Movie")
            .onAppear {
                moviesViewModel.getTopMovies(pageNum: 1)
            }
        .ignoresSafeArea()
    }
}


struct moviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MainBackgroundView(moviesViewModel: .init())
    }
}
