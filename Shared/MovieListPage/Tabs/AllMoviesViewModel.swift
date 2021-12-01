//
//  AllMoviesViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 1.12.2021.
//

import Foundation

final class AllMoviesViewModel:ObservableObject{
    @Published var allMovies: [Movie] = []
    @Published var totalMovieNumber = 0
    @Published var pageNum = 1
    @Published var searchMovie = ""

    init(){
        getTopMovies(pageNum: 1)
    }
    
    func getTopMovies(pageNum: Int){
        MoviesApi().fetchMovie(pageNum: pageNum) { [weak self] movies in
            self?.totalMovieNumber = movies.count
            self?.allMovies.append(contentsOf: movies)
        }
    }
    
    func updateMovies()-> Int{
        pageNum += 1
        totalMovieNumber = allMovies.count
        return pageNum
    }
}
