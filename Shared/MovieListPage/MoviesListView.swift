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
    @State private var selection = 1
    
    var body: some View{
        NavigationView {
            TabView(selection: $selection){
                List (searchResult, id: \.id){ movie in
                    //List (moviesViewModel.topTwo, id: \.id){ movie in
                    movieCell(movie: movie)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Top \(moviesViewModel.totalMovieNumber) Movies")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
                
                Text("Bookmark Tab")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "bookmark.circle.fill")
                        Text("Bookmark")
                    }
                    .tag(1)
                
            }
            
        }.navigationBarHidden(true)
            .searchable(text: $moviesViewModel.searchMovie, prompt: "Search Movie")
            .onAppear{
                moviesViewModel.getTopMovies()
            }
        
    }
    
    
    
    var searchResult: [Movie] {
        //moviesViewModel.searchMovies(title: moviesViewModel.searchMovie)
        guard moviesViewModel.searchMovie.isEmpty else { return moviesViewModel.searchResults}
        return moviesViewModel.topTwo
    }
    
}





struct movieCell: View{
    var movie: Movie
    
    var body: some View{
        NavigationLink(destination: MovieDetailsView(movie: movie)) {
            HStack{
                KFImage(URL(string: movie.image ?? "")!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 70)
                    .cornerRadius(4)
                    .padding(.vertical, 4)
                
                
                VStack(alignment: .leading, spacing: 2){
                    Text(movie.title ?? "")
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    
                    Text(movie.year ?? "")
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

