//
//  StringExtensions.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 12.12.2021.
//

import Foundation

//String Extension
extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

}
