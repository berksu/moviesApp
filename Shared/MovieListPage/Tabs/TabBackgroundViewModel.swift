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
    
    func searchMovies(title: String){
        MovieSearchApi().searchMovie(title: title) { [weak self] searchResult in
            self?.searchResults = searchResult
        }
    }
}
