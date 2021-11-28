//
//  UserInfo.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 27.11.2021.
//

import Foundation
import Firebase

final class UserInfoApi{
    func saveUserInfo(data: UserInfo, completion: @escaping(Bool) -> Void){
        guard let userID = Auth.auth().currentUser?.uid else { return}
        let db = Firestore.firestore()
        
        db.collection("\(userID)_info").document("info").setData([
            "username": data.userName ?? "",
            "url": data.url ?? "",
            "hashatag": data.hashtag ?? "",
            "follower": data.follower ?? ""
        ]){err in
            if let err = err{
                completion(false)
                print("Add data error \(err)")
            }else{
                completion(true)
                print("Document added")
            }
        }
    }
    
    
    func getUserInfo(completion: @escaping (UserInfo) -> Void){
        var user: UserInfo = UserInfo(userName: "", url: "")
        if let userID = Auth.auth().currentUser?.uid{
            let db = Firestore.firestore()
            
            db.collection("\(userID)_info").getDocuments { (querySnapshot, err) in
                if let err = err {
                    completion(user)
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        if(document.documentID == "info"){
                            let data = document.data()
                            user = UserInfo(userName: data["username"]! as? String ?? "",
                                            url: data["url"]! as? String,
                                            hashtag: data["hashtag"]! as? String,
                                            follower: data["follower"]! as? String)
                        }
                    }
                    
                    completion(user)
                }
            }
        } else{
            completion(user)
            print("Cannot reach firebase")
            return
        }
    }
    
    
    func updateUserInfo(completion: @escaping(Bool) -> Void){
        
    }
}
