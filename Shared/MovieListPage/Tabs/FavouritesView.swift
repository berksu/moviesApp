//
//  FavouritesView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 28.11.2021.
//

import SwiftUI

struct FavouritesView: View{
    // 11 - ViewModel'i ayır
    @ObservedObject var moviesViewModel: MovieListViewModel
    
    var body: some View{
        ScrollView(showsIndicators: false){
            LazyVStack{
                ForEach(moviesViewModel.favouriteMovies , id: \.id) { movie in
                    VStack{
                        Divider()
                        NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie))) {
                            MovieCellView(image: movie.image, title: movie.title, releaseDate: movie.release_date)
                        }
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .onAppear{
            moviesViewModel.getFavouriteMovies()
        }
    }
}


struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView(moviesViewModel: MovieListViewModel())
    }
}
