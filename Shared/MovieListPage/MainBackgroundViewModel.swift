//
//  MovieListViewModel.swift
//  movie
//
//  Created by Berksu Kısmet on 12.11.2021.
//

import SwiftUI

final class MainBackgroundViewModel: ObservableObject{    
    //{
    //    didSet {
    //        searchMovies(title: searchMovie)
    //    }
    //}
    //@Published var searchResult: [Movie] =  []
    
    
    //    func findFavouriteMoviesInAll(){
    //        var fav_ids:[Int] = []
    //        favouriteMovies.indices.filter { favouriteMovies[$0].isFavourite == true }
    //            .forEach { fav_ids.append(favouriteMovies[$0].id) }
    //
    //        for index in 0..<allMovies.count{
    //            if(fav_ids.contains(allMovies[index].id)){
    //                allMovies[index].isFavourite = true
    //            }
    //        }
    //    }
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


