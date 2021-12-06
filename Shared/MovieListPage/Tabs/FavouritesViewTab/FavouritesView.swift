//
//  FavouritesView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 28.11.2021.
//

import SwiftUI

struct FavouritesView: View{
    @ObservedObject var favouritesViewModel = FavouritesViewModel()
    @Binding var searchResults: [Movie]

    var body: some View{
        ScrollView(showsIndicators: false){
            LazyVStack{
                ForEach(searchResults.isEmpty ?  favouritesViewModel.favouriteMovies: searchResults, id: \.id) { movie in
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
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView(searchResults: .constant([Movie(id: 1, title: "test", release_date: "test", image: "test", voteAverage: 3.2, voteCount: 1234, overview: "ads")]))
    }
}
