//
//  TextField CustomRoundedStyle.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import SwiftUI

struct TextFieldCustomRoundedStyle: ViewModifier{
    let fieldColor: Color
    func body(content: Content) -> some View{
        return content
            .font(.system(size:16, weight: .medium))
            .foregroundColor(fieldColor)
            .padding()
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 16
                ).stroke(
                    fieldColor
                )
            )
            .padding(.horizontal,15)
    }
}
