//
//  ButtonViewCustomRoundedStyle.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import Foundation
import SwiftUI

struct ButtonViewCustomRoundedStyle: ViewModifier{
    func body(content: Content) -> some View{
        return content
            .font(.system(size:16, weight: .medium))
            .foregroundColor(Color(.red))
            .padding()
            .frame(maxWidth: .infinity)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 16
                ).stroke(
                    Color.red,
                    lineWidth: 3.5
                )
            )
            .padding(.horizontal,15)
    }
}
