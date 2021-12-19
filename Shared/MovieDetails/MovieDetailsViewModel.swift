//
//  MovieDetailsViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 16.11.2021.
//

import Foundation

final class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie
    var favouriteMovies: [Movie] = []
    @Published var isFavourite:Bool = false
    @Published var isAddMovieToCollectionButtonTapped: Bool = false
    @Published var genreStruct:[GenreWithId] = []
    @Published var recommendations:[Movie] = []
    @Published var casts:[Cast] = []

    
    init(movie: Movie) {
        self.movie = movie
        getRecommendations(movieID: movie.id)
        getCredientals(movieID: movie.id)
    }
    
    func movieFavouriteStatusUpdate(){
        isFavourite.toggle()
    }
    
    func isInFavourite(){
        MovieListViewStorage().getFavouriteMovies {[weak self] movies in
            self?.favouriteMovies = movies
            let id_eq = self?.favouriteMovies.indices.filter { self?.favouriteMovies[$0].id == self?.movie.id }
            self?.isFavourite = (id_eq?.count != 0 ? true:false)
        }
    }
    
    func addToDatabase(){
        MovieListViewStorage().addDatabase(movie: movie)
    }
    
    func removeFromDatabase(){
        MovieListViewStorage().removeFromDatabase(movieID: movie.id)
    }
    
    func addMovieToCollectionButton(state: Bool){
        isAddMovieToCollectionButtonTapped = state
    }
        
    func getGenreStrings(genreInt: [Int], genres:[Genre]){
        genreStruct = []
        for i in 0..<genreInt.count{
            if let chosenGenre = genres.firstIndex (where: {$0.id == genreInt[i]}){
                //print(genres[chosenGenre].name)
                //genreStr.append(genres[chosenGenre].name)
                genreStruct.append(GenreWithId(id: String(genres[chosenGenre].id) , name: genres[chosenGenre].name))
                
            }
        }
    }
    
    func getRecommendations(movieID: Int){
        MovieSearchApi().getSimilarMovies(movieID: movieID) {[weak self] movies in
            self?.recommendations = movies
        }
    }
    
    func getCredientals(movieID: Int){
        MovieSearchApi().getCredientals(movieID: movieID) {[weak self] castList in
            self?.casts = castList
        }
    }

}


struct GenreWithId{
    let id: String
    let name:String
}
