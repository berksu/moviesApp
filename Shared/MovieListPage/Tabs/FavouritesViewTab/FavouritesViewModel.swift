//
//  FavouritesViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 1.12.2021.
//

import Foundation

final class FavouritesViewModel: ObservableObject{
    @Published var favouriteMovies : [Movie] = []
    @Published var deepLinkID: Int! = 0
    
    init(){
        getFavouriteMovies()
    }
    
    func getFavouriteMovies(){
        MovieListViewStorage().getFavouriteMovies {[weak self] movies in
            self?.favouriteMovies = movies
        }
    }
    
    func checkDeepLink(url: URL){
        if let host = URLComponents(url: url, resolvingAgainstBaseURL: true)?.host{
            deepLinkID = Int(host) ?? 0
            
        }
    }
}
