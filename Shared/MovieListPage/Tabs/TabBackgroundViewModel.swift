//
//  TabBackgroundViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 2.12.2021.
//

import Foundation
import Combine

final class TabBackgroundViewModel: ObservableObject{
    @Published var searchMovie = ""
    @Published var searchResults: [Movie] = []
    var searchedPage = 1
    
    var cancellables = Set<AnyCancellable>()
        
    init(){
        searchMovieOnTime()
    }
    
    func searchMovieOnTime(){
        $searchMovie
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink{keyword in
                self.searchedPage = 1
                self.searchMovies(title: self.searchMovie, page: self.searchedPage)
            }
            .store(in: &cancellables)
    }
    
    func searchMovies(title: String, page: Int){
        MovieSearchApi().searchMovie(title: title, page: page) { [weak self] searchResult in
            self?.searchResults = searchResult
            self?.searchedPage += 1
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
}
