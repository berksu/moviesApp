//
//  MovieCellViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 1.12.2021.
//

import Foundation

struct MovieCellViewModel{
    func getYearFromRelaseDate(releaseDate: String) -> String{
        if releaseDate.count >= 4{
            return releaseDate[0..<4]
        }
        return ""
    }
}
