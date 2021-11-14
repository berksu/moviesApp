//
//  MovieSearchApi.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 13.11.2021.
//

import Foundation
import Alamofire

final class MovieSearchApi{
    
    typealias completion = ([Movie]) -> Void
    
    func searchMovie(title: String, completion: @escaping completion){
        AF.request("https://imdb-api.com/en/API/Search/k_4qnwncq4/"+title).response { response in
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
}
