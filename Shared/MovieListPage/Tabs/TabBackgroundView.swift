//
//  TabView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 1.12.2021.
//

import SwiftUI
import Kingfisher

struct TabBackgroundView: View {
    @Binding var isSideMenuShow: Bool

    //AppStorage and userdefaults tried
    @AppStorage("tabSelection") private var selection: Int = 0
    //@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    //UserDefaults.standard.set(self.tapCount, forKey: "Tap")

    @ObservedObject var viewModel = TabBackgroundViewModel()
    
    var body: some View {
        TabView(selection: $selection){
            AllMoviesView(searchResults: $viewModel.searchResults)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
            
            
            FavouritesView(searchResults: $viewModel.searchResults)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourites")
                }
                .tag(1)
            
        }
        .searchable(text: $viewModel.searchMovie, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Movie")
        .navigationTitle(selection == 0 ? "Top Movies": "Favourite Movies") // bu satır constraint hatası verdiriyor

        // 3 principal
        .toolbar{
//            ToolbarItem(placement: .principal) {
//                Text(selection == 0 ? "Top \(moviesViewModel.allMovies.count) Movies": "Favourite Movies")
//            }
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

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBackgroundView(isSideMenuShow: .constant(false))
    }
}
