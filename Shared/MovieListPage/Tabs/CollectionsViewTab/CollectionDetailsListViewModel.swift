//
//  CollectionDetailsListViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 5.12.2021.
//

import Foundation
import SwiftUI

final class CollectionDetailsListViewModel: ObservableObject{
    @Published var collectedMovies:[Movie] = []
    
    func fetchMovies(movieIDs: [Int]){
        for i in 0..<movieIDs.count{
            MovieSearchApi().getMovieById(id: movieIDs[i]) {movie in
                self.collectedMovies.append(movie)
            }
        }
    }
}
