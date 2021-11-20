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
    
    
    
    
    func getFavouriteMovies(){
        favouriteMovies = []
        if let userID = Auth.auth().currentUser?.uid{
            let db = Firestore.firestore()
            
            db.collection(userID).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let data = document.data()
                        let tempMovie = Movie(id: data["id"]! as! Int,
                                              title: data["title"]! as? String,
                                              release_date: data["release_date"]! as? String,
                                              image: data["image"]! as? String,
                                              vote_average: data["vote_average"]! as? Float,
                                              vote_count: data["vote_count"]! as? Float,
                                              overview: data["overview"]! as? String,
                                              isFavourite: data["isFavourite"]! as! Bool)
                        self.favouriteMovies.append(tempMovie)
                    }
                    if !self.topTwo.isEmpty {
                        self.findFavouriteMoviesInAll()
                    }
                }
            }
            
            
        } else{
            print("Cannot reach firebase")
            return
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
