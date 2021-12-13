//
//  TabBackgroundViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 2.12.2021.
//

import Foundation
import Combine
import UIKit
import SwiftUI

final class MainBackgroundViewModel: ObservableObject{
    @Published var allMovies: [Movie] = []
    @Published var totalMovieNumber = 0
    var pageNum = 2
    var popularMoviesTotalPage = 0
    var searchedMoviesTotalPage = 0

    @Published var searched_pageNum:Int = 1
    @Published var searched_title:Int = 1
    
    @Published var latestMovies: [Movie] = []
    
    var genres:[Genre] = []
    
    
    @Published var searchMovie = ""
    @Published var searchResults: [Movie] = []
    var searchedPage = 1
    
    var cancellables = Set<AnyCancellable>()
        
    init(){
        searchMovieOnTime()
        getTopMovies(pageNum: 2)
        getLatestMovies()
    }
    
    func searchMovieOnTime(){
        $searchMovie
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink{keyword in
                self.searchResults = []
                self.searchedPage = 1
                self.searchMovies(title: self.searchMovie, page: self.searchedPage)
            }
            .store(in: &cancellables)
    }
    
    func searchMovies(title: String, page: Int){
        if(searchedPage < searchedMoviesTotalPage || searchedPage == 1){
            let newString = title.replacingOccurrences(of: " ", with: "%20")
            
            MovieSearchApi().searchMovie(title: newString, page: searchedPage) { [weak self] searchResult in
                //self?.searchResults = searchResult
                self?.searchResults.append(contentsOf: searchResult.results)
                self?.searchedMoviesTotalPage = searchResult.totalPage ?? 99
                self?.searchedPage += 1
            }
        }
    }
    
    func determineTheTitle(tabNo: Int) -> String{
        switch tabNo{
        case 0:
            return "Top Movies"
        case 1:
            return "Favourite Movies"
        case 2:
            return "Collections"
        default:
            return ""
        }
    }
    
    func getLatestMovies(){
        MovieSearchApi().getLatestMovies { [weak self] movies in
            self?.latestMovies = movies
        }
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
        if(pageNum < popularMoviesTotalPage || pageNum == 2){
            pageNum += 1
            totalMovieNumber = allMovies.count
        }
        return pageNum
    }
    
    
    func getGenres(){
        MovieSearchApi().fetchGenres { [weak self]
             genres in
            self?.genres = genres
        }
    }
    
    func getGenreStrings(genreInt: [Int]){
        var genreStr:[String] = []
        for i in 0..<genreInt.count{
            if let chosenGenre = genres.firstIndex (where: {$0.id == genreInt[i]}){
                print(chosenGenre)
            }
        }
        print(genreStr)
    }
}

