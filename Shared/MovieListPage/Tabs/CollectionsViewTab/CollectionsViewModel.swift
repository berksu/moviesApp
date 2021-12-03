//
//  CollectionsViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 3.12.2021.
//

import Foundation

final class CollectionsViewModel: ObservableObject{
    @Published var collections: [CollectionModel] = [CollectionModel(id: 1, title: "Horror"), CollectionModel(id: 2, title: "Comedy")]
    @Published var isCollectionAddTapped = false
    var id = 3
    
    func addNewCollection(){
        id = collections.count + 1
        isCollectionAddTapped = true
    }
    
    func isCollectionAddTappedUpdate(state: Bool) {
        isCollectionAddTapped = state
    }
}
