//
//  MoviesApi.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 13.11.2021.
//

import Foundation
import Alamofire

final class MoviesApi{
    
    typealias completion = ([Movie]) -> Void
    
    func fetchMovie(completion: @escaping completion){
        AF.request("https://imdb-api.com/en/API/Top250TVs/k_21lu02du").response { response in
            debugPrint(response.error)
        
            guard let data = response.data
            else{
                return
            }
            
            do{
                let movies = try JSONDecoder().decode(MoviesList.self, from: data)
                completion(movies.items)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
}
