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
    var popularMoviesTotalPage = 0
    
    @Published var searched_pageNum:Int = 1
    @Published var searched_title:Int = 1
    
    @Published var latestMovies: [Movie] = []
    
    var genres:[Genre] = []

    
    init(){
        getTopMovies(pageNum: 1)
        getLatestMovies()
        getGenres()
        
    }
    
    func getTopMovies(pageNum: Int){
        MoviesApi().fetchMovie(pageNum: pageNum) { [weak self] movieList in
            self?.totalMovieNumber = movieList.results.count
            self?.allMovies.append(contentsOf: movieList.results)
            self?.popularMoviesTotalPage = movieList.total_pages ?? 99
            self?.updateMovies()
        }
    }
    
    @discardableResult
    func updateMovies()-> Int{
        if(pageNum < popularMoviesTotalPage){
            pageNum += 1
            totalMovieNumber = allMovies.count
        }
        return pageNum
    }
    
    func searchMovies(title: String, completion: @escaping ([Movie]) -> Void){
        MovieSearchApi().searchMovie(title: title, page: searched_pageNum) { [weak self] searchResult in
            self?.searched_pageNum += 1
            completion(searchResult)
        }
    }
    
    func getLatestMovies(){
        MovieSearchApi().getLatestMovies { [weak self] movies in
            self?.latestMovies = movies
        }
    }
    
    func getGenres(){
        MovieSearchApi().fetchGenres { [weak self]
             genres in
            self?.genres = genres
        }
    }
}
