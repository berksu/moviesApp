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
    
    @Published var searched_pageNum:Int = 1
    @Published var searched_title:Int = 1
    
    init(){
        getTopMovies(pageNum: 1)
    }
    
    func getTopMovies(pageNum: Int){
        MoviesApi().fetchMovie(pageNum: pageNum) { [weak self] movies in
            self?.totalMovieNumber = movies.count
            self?.allMovies.append(contentsOf: movies)
            self?.updateMovies()
        }
    }
    
    @discardableResult
    func updateMovies()-> Int{
        pageNum += 1
        totalMovieNumber = allMovies.count
        return pageNum
    }
    
    func searchMovies(title: String, completion: @escaping ([Movie]) -> Void){
        MovieSearchApi().searchMovie(title: title, page: searched_pageNum) { [weak self] searchResult in
            self?.searched_pageNum += 1
            completion(searchResult)
        }
    }
}
