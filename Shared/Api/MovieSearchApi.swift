//
//  MovieSearchApi.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 13.11.2021.
//

import Foundation
import Alamofire
import Combine


final class MovieSearchApi{
    
    typealias completion = ([Movie]) -> Void
    
    func searchMovie(title: String, completion: @escaping completion) {
        AF.request("https://api.themoviedb.org/3/search/movie?api_key=5c011e8f93fae74da4b04f2a25562db2&language=en-US&query=\(title)&page=1&include_adult=true").response { response in
            debugPrint(response)
            
            guard let data = response.data
            else{
                return
            }
            
            do{
                let searchResult = try JSONDecoder().decode(MovieSearchList.self, from: data)
                completion(searchResult.results)
            }catch{
                print(error.localizedDescription)
                completion([])
            }
            
        }
        
    }
    
    
    func searchMovie_combine(title: String) -> DataResponsePublisher<Movie> {
        return AF.request("https://imdb-api.com/en/API/Search/k_4qnwncq4/"+title).response { response in
            debugPrint(response)
            
            guard let data = response.data
            else{
                return
            }
            
            do{
                let searchResult = try JSONDecoder().decode(MovieSearchList.self, from: data)
            }catch{
                print(error.localizedDescription)

            }
            
        }.publishDecodable()
        
    }
    
    
    
    /*func searcedMovies(title: String) -> AnyPublisher<Movie, AFError> {
        return searchMovie_combine(title: title)
            .mapError{ _ in
                return AFError.sessionDeinitialized
            }
            .value()
    }*/
    
}
