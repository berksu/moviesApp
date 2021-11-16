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
                    .ignoresSafeArea()
            }
            
        }
        .navigationBarHidden(true)
            .searchable(text: $moviesViewModel.searchMovie, prompt: "Search Movie")
            .onAppear{
                moviesViewModel.getTopMovies()
            }
        .ignoresSafeArea()
            
    }
    
}





struct movieCell: View{
    var movie: Movie
    
    var body: some View{
        NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie))) {
            HStack{
                if let im = movie.image{
                    KFImage(URL(string: "https://www.themoviedb.org/t/p/w1280\(im)"))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                        .cornerRadius(4)
                        .padding(.vertical, 4)
                }else{
                    KFImage(URL(string: ""))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                        .cornerRadius(4)
                        .padding(.vertical, 4)
                }
                
                
                VStack(alignment: .leading, spacing: 2){
                    Text(movie.title ?? "test")
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    
                    Text(movie.release_date![0..<4] ?? "test2")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
            }
        }
        
    }
}



struct moviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(moviesViewModel: .init())
    }
}


struct HomeView: View {
    @ObservedObject var moviesViewModel: MovieListViewModel
    @State private var selection = 0
    @Binding var isSideMenuShow: Bool
    

    var body: some View {
        TabView(selection: $selection){
            List (moviesViewModel.searchResults.isEmpty ?  moviesViewModel.topTwo: moviesViewModel.searchResults, id: \.id){ movie in
                //List (moviesViewModel.topTwo, id: \.id){ movie in
                movieCell(movie: movie)
            }
            .listStyle(PlainListStyle())
            
            .navigationTitle("Top \(moviesViewModel.totalMovieNumber) Movies")
            //.navigationBarTitleDisplayMode(.inline)
            
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }.tag(0)
            
            Text("Favourites")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourites")
                }
                .tag(1)
            
        }
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
