//
//  MovieListViewStorage.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 22.11.2021.
//

import Foundation
import Firebase

struct MovieListViewStorage{
    
    func getFavouriteMovies(completion: @escaping ([Movie]) -> Void){
        var favouriteMovies:[Movie] = []
        if let userID = Auth.auth().currentUser?.uid{
            let db = Firestore.firestore()
            
            db.collection(userID).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    completion([])
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let data = document.data()
                        let tempMovie = Movie(id: data["id"]! as! Int,
                                              title: data["title"]! as? String,
                                              release_date: data["release_date"]! as? String,
                                              image: data["image"]! as? String,
                                              vote_average: data["vote_average"]! as? Float,
                                              vote_count: data["vote_count"]! as? Float,
                                              overview: data["overview"]! as? String)
                        favouriteMovies.append(tempMovie)
                    }
                    
                    completion(favouriteMovies)
                }
            }
        } else{
            print("Cannot reach firebase")
            return
        }
    }
    
    
    func addDatabase(movie: Movie){
        guard let userID = Auth.auth().currentUser?.uid else { return}
        let db = Firestore.firestore()
        
        db.collection(userID).document(String(movie.id)).setData([
            "id": movie.id,
            "overview": movie.overview ?? "No overview is given",
            "release_date": movie.release_date ?? "No release date is given",
            "title": movie.title ?? "No title date is given",
            "vote_average": movie.vote_average ?? 0.0,
            "vote_count": movie.vote_count ?? 0.0,
            "image": movie.image ?? ""
        ]){err in
            if let err = err{
                print("Add data error \(err)")
            }else{
                print("Document added")
            }
        }
    }
    
    
    func removeFromDatabase(movieID: Int){
        guard let userID = Auth.auth().currentUser?.uid else { return}
        let db = Firestore.firestore()
        
        db.collection(userID).document(String(movieID)).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
}
