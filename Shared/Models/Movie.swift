//
//  Movie.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 13.11.2021.
//

import Foundation

struct Movie: Codable{
    let id : String
    let title: String?
    let year: String?
    let image: String?
    let imDbRating: String?
    let ratingCount: String?
    
    enum CodingKeys: String, CodingKey{
        case id, title, year , image, imDbRating, ratingCount = "imDbRatingCount"
    }
}
