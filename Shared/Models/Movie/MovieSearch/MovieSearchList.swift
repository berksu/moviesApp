//
//  MovieSearchList.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 13.11.2021.
//

import Foundation

struct MovieSearchList: Codable{
    let results: [Movie]
    let totalPage: Int?
    enum CodingKeys: String, CodingKey{
        case results, totalPage = "total_pages"
    }
}
