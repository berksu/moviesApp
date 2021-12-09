//
//  PlaceholderStyle.swift
//  movie
//
//  Created by Berksu Kısmet on 9.12.2021.
//

import SwiftUI

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                .padding(.horizontal, 15)
            }
            content
            .foregroundColor(Color(red: 162/255, green: 162/255, blue: 162/255))
            .padding(5.0)
        }
    }
}
