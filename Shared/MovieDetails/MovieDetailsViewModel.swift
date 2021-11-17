//
//  MovieDetailsViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 16.11.2021.
//

import Foundation

final class MovieDetailsViewModel: ObservableObject {
    let movie: Movie
    @Published var isFavourite: Bool = false
    
    init(movie: Movie) {
        self.movie = movie
    }
}
