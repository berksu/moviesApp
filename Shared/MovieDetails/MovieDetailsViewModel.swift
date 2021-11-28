//
//  MovieDetailsViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 16.11.2021.
//

import Foundation

final class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }
    
    func movieFavouriteStatusUpdate(){
        movie.isFavourite.toggle()
    }
    
    func addToDatabase(){
        MovieListViewStorage().addDatabase(movie: movie)
    }
    
    func removeFromDatabase(){
        MovieListViewStorage().removeFromDatabase(movieID: movie.id)
    }

}
