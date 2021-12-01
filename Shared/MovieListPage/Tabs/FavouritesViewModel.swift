//
//  FavouritesViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 1.12.2021.
//

import Foundation

final class FavouritesViewModel: ObservableObject{
    @Published var favouriteMovies : [Movie] = []

    func getFavouriteMovies(){
        MovieListViewStorage().getFavouriteMovies {[weak self] movies in
            self?.favouriteMovies = movies
            //self?.getTopMovies(pageNum: self?.pageNum ?? 1)
        }
    }
}
