//
//  movie.swift
//  movie
//
//  Created by Berksu Kısmet on 12.11.2021.
//

import SwiftUI

struct Movie: Identifiable{
    let id = UUID()
    let movieName: String
    let movieDate: String
    let movieImage: String
}


struct movieList{
    static let topTwo = [
        Movie(movieName: "Inception",
              movieDate: "2018",
              movieImage: "login_bg1"),
        
        Movie(movieName: "Harry Potter",
              movieDate: "1999",
              movieImage: "login_bg2"),
        
        Movie(movieName: "Inception",
              movieDate: "2018",
              movieImage: "login_bg1"),
        
        Movie(movieName: "Harry Potter",
              movieDate: "1999",
              movieImage: "login_bg2"),
        
        Movie(movieName: "Inception",
              movieDate: "2018",
              movieImage: "login_bg1"),
        
        Movie(movieName: "Harry Potter",
              movieDate: "1999",
              movieImage: "login_bg2"),
        
        Movie(movieName: "Inception",
              movieDate: "2018",
              movieImage: "login_bg1"),
        
        Movie(movieName: "Harry Potter",
              movieDate: "1999",
              movieImage: "login_bg2"),
        
        Movie(movieName: "Inception",
              movieDate: "2018",
              movieImage: "login_bg1"),
        
        Movie(movieName: "Harry Potter",
              movieDate: "1999",
              movieImage: "login_bg2")
    ]
}
