//
//  AddCollectionViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 4.12.2021.
//

import Foundation

final class AddCollectionViewModel: ObservableObject{
    @Published var collectionNameText = ""
    
    func addToDatabase(){
        if(collectionNameText != ""){
            CollectionViewStorage().addCollectionToDatabase(collection: CollectionModel(id: UUID().uuidString, title: collectionNameText, movieIDs: []))
        }
    }
}
