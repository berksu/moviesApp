//
//  MovieListViewModel.swift
//  movie
//
//  Created by Berksu Kısmet on 12.11.2021.
//

import SwiftUI
import Kingfisher
import Combine

final class MovieListViewModel: ObservableObject{
    @Published var topTwo:[Movie] = []
    @Published var searchResults:[Movie] = []
    @Published var totalMovieNumber = 0
    @Published var searchMovie = ""

    //{
    //    didSet {
    //        searchMovies(title: searchMovie)
    //    }
    //}
    //@Published var searchResult: [Movie] =  []

    var cancellables = Set<AnyCancellable>()
   
    init(){
        //setUpBindings()
        searchMovieOnTime
            .receive(on: RunLoop.main)
            .map{valid in
                if(valid){
                    self.searchMovies(title: self.searchMovie)
                }
            }
            .sink{keyword in
               //print(keyword)
            }
            //.assign(to: \.isValid, on: self)
            .store(in: &cancellables)
            
    }
    
    
    
    private var searchMovieOnTime: AnyPublisher<Bool,Never>{
        $searchMovie
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{input in
                return input.count > 2
            }
            .eraseToAnyPublisher()
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
    
    
    func getTopMovies(){
        MoviesApi().fetchMovie { [weak self] movies in
            print(movies.count)
            self?.totalMovieNumber = movies.count
            self?.topTwo = movies
        }
    }
    
    
    func searchMovies(title: String){
        MovieSearchApi().searchMovie(title: title) { [weak self] searchResult in
            self?.searchResults = searchResult
            print(searchResult.count)
        }
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
