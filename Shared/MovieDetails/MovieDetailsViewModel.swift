//
//  MovieDetailsViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 16.11.2021.
//

import Foundation

final class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie
    var favouriteMovies: [Movie] = []
    @Published var isFavourite:Bool = false

    init(movie: Movie) {
        self.movie = movie
    }
    
    func movieFavouriteStatusUpdate(){
        isFavourite.toggle()
    }
    
    func isInFavourite(){
        MovieListViewStorage().getFavouriteMovies {[weak self] movies in
            self?.favouriteMovies = movies
            let id_eq = self?.favouriteMovies.indices.filter { self?.favouriteMovies[$0].id == self?.movie.id }
            self?.isFavourite = (id_eq?.count != 0 ? true:false)
        }
    }
    
    func addToDatabase(){
        MovieListViewStorage().addDatabase(movie: movie)
    }
    
    func removeFromDatabase(){
        MovieListViewStorage().removeFromDatabase(movieID: movie.id)
    }

}
