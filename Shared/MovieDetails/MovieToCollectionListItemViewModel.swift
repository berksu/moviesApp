//
//  MovieToCollectionListItemViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 5.12.2021.
//

import Foundation

final class MovieToCollectionListItemViewModel:ObservableObject{
    @Published var isCellTapped: Bool = false
    
    func controlIsMovieInCollection(movieIDs: [Int], movieID: Int){
        isCellTapped = movieIDs.contains(movieID)
    }
    
    func isCellButtonTapped(){
        isCellTapped.toggle()
    }
    
    func appendMovieToCollection(collection: CollectionModel, movieID: Int) -> CollectionModel{
        var tempMovieIDs = collection.movieIDs
        tempMovieIDs?.append(movieID)
        let tempCollection = CollectionModel(id: collection.id,
                                             title: collection.title,
                                             movieIDs: tempMovieIDs)
        return tempCollection
    }
    
    func removeMovieToCollection(collection: CollectionModel, movieID: Int) -> CollectionModel{
        var tempCollection = CollectionModel(id: collection.id,
                                             title: collection.title,
                                             movieIDs: [])
        if let tempMovieIDs = collection.movieIDs{
            let removedIDs = tempMovieIDs.filter{$0 != movieID}
            tempCollection.movieIDs = removedIDs
        }
        return tempCollection
    }
    
    func updateCollection(collection: CollectionModel, movieID: Int){
        var updatingCollection: CollectionModel
        if(isCellTapped){
            updatingCollection = appendMovieToCollection(collection: collection, movieID: movieID)
        }else{
            updatingCollection = removeMovieToCollection(collection: collection, movieID: movieID)
        }
        CollectionViewStorage().updateCollection(collection: updatingCollection)
    }
}
