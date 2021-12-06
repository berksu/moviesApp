//
//  CollectionViewStorage.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 4.12.2021.
//

import Foundation
import Firebase

struct CollectionViewStorage{
    
    func getAllCollections(completion: @escaping ([CollectionModel]) -> Void){
        var collections:[CollectionModel] = []
        if let userID = Auth.auth().currentUser?.uid{
            let db = Firestore.firestore()
            
            db.collection("\(userID)_c").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    completion([])
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        let data = document.data()
                        let tempCollection = CollectionModel(id: data["id"]! as! String,
                                                    title: data["title"]! as? String,
                                                    movieIDs: data["movieIDs"] as? [Int])
                        collections.append(tempCollection)
                    }
                    completion(collections)
                }
            }
        } else{
            print("Cannot reach firebase")
            return
        }
    }
    
    
    func addCollectionToDatabase(collection: CollectionModel){
        guard let userID = Auth.auth().currentUser?.uid else { return}
        let db = Firestore.firestore()
        
        db.collection("\(userID)_c").document(String(collection.id)).setData([
            "id": collection.id,
            "title": collection.title ?? "",
            "movieIDs": collection.movieIDs ?? []
        ]){err in
            if let err = err{
                print("Add data error \(err)")
            }else{
                print("Document added")
            }
        }
    }
    
    
    func removeCollectionFromDatabase(collection: CollectionModel){
        guard let userID = Auth.auth().currentUser?.uid else { return}
        let db = Firestore.firestore()
        
        db.collection("\(userID)_c").document(String(collection.id)).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func updateCollection(collection: CollectionModel){
        guard let userID = Auth.auth().currentUser?.uid else { return}
        let db = Firestore.firestore()
        
        let ref = db.collection("\(userID)_c").document(String(collection.id))
        
        ref.updateData([
            "title": collection.title ?? "",
            "movieIDs": collection.movieIDs ?? []
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
}
