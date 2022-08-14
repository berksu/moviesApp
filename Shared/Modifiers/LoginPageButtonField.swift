//
//  LoginPageButtonField.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 8.12.2021.
//

import SwiftUI

struct LoginPageButtonField: ViewModifier{
    func body(content: Content) -> some View{
        return content
            .font(.system(size:16, weight: .medium))
            .foregroundColor(Color(red: 255/255, green: 187/255, blue: 59/255))
            .padding()
            .frame(maxWidth: .infinity)
            //.background(LinearGradient(gradient: Gradient(colors: [Color(red: 255/255, green: 187/255, blue: 59/255), Color(red: 255/255, green: 169/255, blue: 10/255)]), startPoint: .top, endPoint: .bottom))
            .overlay(
                RoundedRectangle(
                    cornerRadius: 16
                ).stroke(
                    Color(red: 255/255, green: 187/255, blue: 59/255),
                    lineWidth: 3.5
                )
            )
            .cornerRadius(9)
    }
}
