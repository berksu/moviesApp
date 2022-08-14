//
//  MovieToCollectionViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 5.12.2021.
//

import Foundation

final class MovieToCollectionViewModel: ObservableObject{
    @Published var collections:[CollectionModel] = []
    
    init(){
        self.fetchCollectionsFromDatabase()
    }
    
    func fetchCollectionsFromDatabase(){
        CollectionViewStorage().getAllCollections {[weak self] allCollections in
            self?.collections = allCollections
        }
    }
}
