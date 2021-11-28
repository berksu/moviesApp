//
//  MovieListViewModel.swift
//  movie
//
//  Created by Berksu Kısmet on 12.11.2021.
//

import SwiftUI
import Combine

final class MovieListViewModel: ObservableObject{
    @Published var allMovies:[Movie] = []
    @Published var searchResults:[Movie] = []
    @Published var totalMovieNumber = 0
    @Published var searchMovie = ""
    @Published var favouriteMovies:[Movie] = []
    @Published var pageNum = 1

    //{
    //    didSet {
    //        searchMovies(title: searchMovie)
    //    }
    //}
    //@Published var searchResult: [Movie] =  []

    var cancellables = Set<AnyCancellable>()
   
    init(){
        searchMovieOnTime()
    }
    
    func searchMovieOnTime(){
        $searchMovie
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink{keyword in
                self.searchMovies(title: self.searchMovie)
            }
            .store(in: &cancellables)
    }
    
    func getTopMovies(pageNum: Int){
        MoviesApi().fetchMovie(pageNum: pageNum) { [weak self] movies in
            print(movies.count)
            self?.totalMovieNumber = movies.count
            self?.allMovies += movies
            
            self?.findFavouriteMoviesInAll()
        }
    }
    
    func searchMovies(title: String){
        MovieSearchApi().searchMovie(title: title) { [weak self] searchResult in
            self?.searchResults = searchResult
        }
    }
    
    func getFavouriteMovies(){
        MovieListViewStorage().getFavouriteMovies {[weak self] movies in
            self?.favouriteMovies = movies
            self?.getTopMovies(pageNum: self?.pageNum ?? 1)
        }
    }
    
    func findFavouriteMoviesInAll(){
        var fav_ids:[Int] = []
        favouriteMovies.indices.filter { favouriteMovies[$0].isFavourite == true }
            .forEach { fav_ids.append(favouriteMovies[$0].id) }

        for index in 0..<allMovies.count{
            if(fav_ids.contains(allMovies[index].id)){
                allMovies[index].isFavourite = true
            }
        }
    }

    func updateMovies()-> Int{
        pageNum += 1
        totalMovieNumber = allMovies.count
        return pageNum
    }
}


//String Extension
extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

}


