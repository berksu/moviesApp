//
//  TextField CustomRoundedStyle.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import Foundation
import SwiftUI

struct TextFieldCustomRoundedStyle: ViewModifier{
    func body(content: Content) -> some View{
        return content
            .font(.system(size:16, weight: .medium))
            .foregroundColor(Color(.black))
            .padding()
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 16
                ).stroke(
                    Color.black
                )
            )
            .padding(.horizontal,15)
    }
}
