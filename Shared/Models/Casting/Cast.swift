//
//  Cast.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 19.12.2021.
//

import Foundation

struct Cast: Codable{
    let id: Int
    let gender: Int?
    let name: String?
    let profilePath: String?
    let character: String?
    enum CodingKeys: String, CodingKey{
        case id, gender, name, profilePath = "profile_path",character
    }
}
