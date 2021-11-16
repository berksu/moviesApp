//
//  MoviesList.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 13.11.2021.
//

import Foundation


struct MoviesList: Codable{
    //let items: [Movie]
    let page: Int
    let results: [Movie]
    let total_pages: Int?
    let total_results: Int?
}

