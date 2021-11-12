//
//  MovieListViewModel.swift
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


final class MovieListViewModel: ObservableObject{
    @Published var topTwo:[Movie] = []
    
    init(){
        getTopMovies()
    }
    
    func getTopMovies(){
        guard let url = URL(string: "https://www.imdb.com/search/title/?groups=top_100&sort=user_rating,desc&view=simple") else {
            print("Invalid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: url, encoding: .ascii)
            //print("HTML : \(myHTMLString)")
            
            parseHTML(data: myHTMLString, keyword: "> <img alt=")
            
        } catch let error {
            print("Error: \(error)")
        }

    }



    func parseHTML(data:String, keyword: String) {
        
        let indices = data.indicesOf(string: keyword)
        var movieNames:[String] = []
        var movieImageURL:[String] = []
        var imageYear:[String] = []

        var startPoint = 0
        
        for ind in indices{
            startPoint = ind + 12
            var temp = data[startPoint...]
            let ending:Int = temp.indexInt(of: "\"")!
            //print(data[(ind+12)..<(ind+12+ending)])
            let movName = data[startPoint..<(startPoint+ending)]
            movieNames.append(movName)
            
            
            let indexImageData = temp.firstIndicesOf(string: "loadlate")
            temp = temp[(indexImageData+10+10)...]
            let imageEnding:Int = temp.firstIndicesOf(string: "_V1_")
            let movieImage = temp[0..<imageEnding] + "_V1_FMjpg_UY474_.jpg"
            movieImageURL.append(movieImage)
            
            
            let imageYearInd = temp.firstIndicesOf(string: "year text-muted unbold")
            let imageYearInd_end = temp[(imageYearInd+22)...].indexInt(of: "<")!
            let movYear = temp[imageYearInd+25..<(imageYearInd+22+imageYearInd_end-1)]
            imageYear.append(movYear)

            
            topTwo.append(Movie(movieName: movName, movieDate: movYear, movieImage: movieImage))
        }
    }
    
    

}











//String Extensions
extension String {
    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex

        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }

        return indices
    }
    
    
    func firstIndicesOf(string: String) -> Int {
        var indices: Int = 0
        var searchStartIndex = self.startIndex

        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices = index
            break
        }

        return indices
    }
}



extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}



public extension String {
  func indexInt(of char: Character) -> Int? {
    return firstIndex(of: char)?.utf16Offset(in: self)
  }
}
