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
    
    func searchMovie(title: String, page: Int, completion: @escaping completion) {
        AF.request("https://api.themoviedb.org/3/search/movie?api_key=5c011e8f93fae74da4b04f2a25562db2&language=en-US&query=\(title)&page=\(page)&include_adult=true").response { response in
            guard let data = response.data
            else{
                return
            }
            
            do{
                let searchResult = try JSONDecoder().decode(MovieSearchList.self, from: data)
                completion(searchResult.results)
                print(searchResult.totalPage)
            }catch{
                //print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func searchMovie_combine(title: String) -> AnyPublisher<Movie,AFError> {
        return AF.request("https://api.themoviedb.org/3/search/movie?api_key=5c011e8f93fae74da4b04f2a25562db2&language=en-US&query=\(title)&page=1&include_adult=true").response { response in
            debugPrint(response)
            
            guard let data = response.data
            else{
                return
            }
            
            do{
                let _ = try JSONDecoder().decode(MovieSearchList.self, from: data)
            }catch{
                print(error.localizedDescription)

            }
            
        }.publishDecodable(type: Movie.self)
            .value()
    }
    
    func getMovieById(id: Int, completion: @escaping (Movie) -> Void){
        AF.request("https://api.themoviedb.org/3/movie/\(id)?api_key=5c011e8f93fae74da4b04f2a25562db2&language=en-US").response { response in
            guard let data = response.data
            else{
                return
            }
            
            do{
                let searchResult = try JSONDecoder().decode(Movie.self, from: data)
                completion(searchResult)
                //print(searchResult)
            }catch{
                //print(error.localizedDescription)
                completion(Movie(id: 999, title: "", release_date: "", image: "", voteAverage: 99.9, voteCount: 99.9, overview: ""))
            }
        }
    }
    
}
