//
//  CollectionsViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 3.12.2021.
//

import Foundation

final class CollectionsViewModel: ObservableObject{
    @Published var collections: [CollectionModel] = []
    @Published var isCollectionAddTapped = false
    var id = 3
    
    
    init(){
        fetchCollectionsFromDatabase()
    }
    
    func addNewCollection(){
        id = collections.count + 1
        isCollectionAddTapped = true
    }
    
    func isCollectionAddTappedUpdate(state: Bool) {
        isCollectionAddTapped = state
    }
    
    func deleteCollectionCell(id: String){
        //collections = collections.filter(){$0.id != id}
        let removedCollection = collections.filter { $0.id == id }
        if(removedCollection.count > 0){
            CollectionViewStorage().removeCollectionFromDatabase(collection: removedCollection[0])
            fetchCollectionsFromDatabase()
        }
    }
    
    func fetchCollectionsFromDatabase(){
        CollectionViewStorage().getAllCollections {[weak self] allCollections in
            self?.collections = allCollections
        }
    }
}
