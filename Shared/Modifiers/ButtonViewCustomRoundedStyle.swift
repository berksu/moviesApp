//
//  ButtonViewCustomRoundedStyle.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import SwiftUI

struct ButtonViewCustomRoundedStyle: ViewModifier{
    let buttonColor: Color
    func body(content: Content) -> some View{
        return content
            .font(.system(size:16, weight: .medium))
            .foregroundColor(buttonColor)
            .padding()
            .frame(maxWidth: .infinity)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 16
                ).stroke(
                    buttonColor,
                    lineWidth: 3.5
                )
            )
            .padding(.horizontal,15)
    }
}
