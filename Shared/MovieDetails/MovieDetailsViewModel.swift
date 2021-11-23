//
//  MovieDetailsViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 16.11.2021.
//

import Foundation
import Firebase

final class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }
    
    func addToDatabase(){
        guard let userID = Auth.auth().currentUser?.uid else { return}
        let db = Firestore.firestore()
        
        db.collection(userID).document(String(movie.id)).setData([
            "id": movie.id,
            "overview": movie.overview ?? "No overview is given",
            "release_date": movie.release_date ?? "No release date is given",
            "title": movie.title ?? "No title date is given",
            "vote_average": movie.vote_average ?? 0.0,
            "vote_count": movie.vote_count ?? 0.0,
            "image": movie.image ?? "",
            "isFavourite": movie.isFavourite
        ]){err in
            if let err = err{
                print("Add data error \(err)")
            }else{
                print("Document added")
            }
        }
    }
    
    
    
    func removeToDatabase(){
        guard let userID = Auth.auth().currentUser?.uid else { return}
        let db = Firestore.firestore()
        
        db.collection(userID).document(String(movie.id)).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
    }
    
    
        
    
}
