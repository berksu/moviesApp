//
//  MoviesListView.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import SwiftUI
import Kingfisher

struct MoviesListView: View {
    @ObservedObject var moviesViewModel = MovieListViewModel()
    @State var isSideMenuShow: Bool = false
    
    var body: some View{
        NavigationView {
            ZStack{
                if(isSideMenuShow){
                    SideMenuView(isSideMenuShow: $isSideMenuShow)
                        
                }
                HomeView(moviesViewModel: moviesViewModel, isSideMenuShow: $isSideMenuShow)
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
        MoviesListView(moviesViewModel: .init())
    }
}


struct HomeView: View {
    @ObservedObject var moviesViewModel: MovieListViewModel
    @Binding var isSideMenuShow: Bool

    //AppStorage and userdefaults tried
    @AppStorage("tabSelection") private var selection: Int = 0
    //@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    //UserDefaults.standard.set(self.tapCount, forKey: "Tap")

    var body: some View {
        TabView(selection: $selection){
            AllMoview(moviesViewModel: moviesViewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
            
            FavouritesView(moviesViewModel: moviesViewModel)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourites")
                }
                .tag(1)
        }
        .navigationTitle(selection == 0 ? "Top \(moviesViewModel.allMovies.count) Movies": "Favourite Movies") // bu satır constraint hatası verdiriyor
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    withAnimation(.spring()){
                        isSideMenuShow.toggle()
                    }
                } label: {
                    KFImage(URL(string: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .shadow(radius: 20)
                        .frame(height: 50)
                        .background(.clear)
                }
            }
        }
    }
}


