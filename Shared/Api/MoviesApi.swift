//
//  MoviesApi.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 13.11.2021.
//

import Foundation
import Alamofire

final class MoviesApi{
    
    typealias completion = (MoviesList) -> Void
    
    func fetchMovie(pageNum:Int, completion: @escaping completion){
        AF.request("https://api.themoviedb.org/3/movie/popular?api_key=5c011e8f93fae74da4b04f2a25562db2&language=en-US&page=\(pageNum)").response { response in
            guard let data = response.data
            else{
                return
            }
            
            do{
                let movies = try JSONDecoder().decode(MoviesList.self, from: data)
                completion(movies)
            }catch{
                print(error.localizedDescription)
                print(error)
            }
        }
    }
    
    
    
    
}
