//
//  MovieListViewModel.swift
//  movie
//
//  Created by Berksu Kısmet on 12.11.2021.
//

import SwiftUI
import Kingfisher
import Combine
import Firebase


final class MovieListViewModel: ObservableObject{
    @Published var topTwo:[Movie] = []
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
        //setUpBindings()
        searchMovieOnTime()
    }
    
    
    
    func searchMovieOnTime(){
        $searchMovie
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink{keyword in
                //print("aaaaa")
                self.searchMovies(title: self.searchMovie)
            }
            .store(in: &cancellables)
    }
    
    
    
    
    func setUpBindings(){
        $searchMovie
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{
                //MovieSearchApi().searcedMovies(title: $0)
                MovieSearchApi().searchMovie_combine(title: $0)
            }
            .sink { keyWord in
                print(keyWord)
            }
            .store(in: &cancellables)
    }
    
    
    func getTopMovies(pageNum: Int){
        MoviesApi().fetchMovie(pageNum: pageNum) { [weak self] movies in
            print(movies.count)
            self?.totalMovieNumber = movies.count
            self?.topTwo += movies
            
            self?.findFavouriteMoviesInAll()
        }
    }
    
    
    func searchMovies(title: String){
        MovieSearchApi().searchMovie(title: title) { [weak self] searchResult in
            self?.searchResults = searchResult
            //signin page de değişen olduğunda buraya giriyor
            //print(searchResult.count)
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

        for index in 0..<topTwo.count{
            if(fav_ids.contains(topTwo[index].id)){
                topTwo[index].isFavourite = true
            }
        }
        
    }

    
    
    func updateMovies()-> Int{
        pageNum += 1
        totalMovieNumber = topTwo.count
        return pageNum
    }
}











//String Extensions
extension String {
    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex

        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }

        return indices
    }
    
    
    func firstIndicesOf(string: String) -> Int {
        var indices: Int = 0
        let searchStartIndex = self.startIndex

        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices = index
            break
        }

        return indices
    }
}



extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}



public extension String {
  func indexInt(of char: Character) -> Int? {
    return firstIndex(of: char)?.utf16Offset(in: self)
  }
}
