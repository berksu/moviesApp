//
//  FavouritesView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 28.11.2021.
//

import SwiftUI

struct FavouritesView: View{
    @ObservedObject var favouritesViewModel = FavouritesViewModel()

    var body: some View{
        ScrollView(showsIndicators: false){
            LazyVStack{
                ForEach(favouritesViewModel.favouriteMovies , id: \.id) { movie in
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
            favouritesViewModel.getFavouriteMovies()
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
