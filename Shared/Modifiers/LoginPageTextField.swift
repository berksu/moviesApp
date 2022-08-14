//
//  LoginPageTextField.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 8.12.2021.
//

import SwiftUI

struct LoginPageTextField: ViewModifier{
    func body(content: Content) -> some View{
        let bgColor = Color(red: 33/255, green: 33/255, blue: 33/255)
        let fontColor = Color(red: 162/255, green: 162/255, blue: 162/255)

        return content
            .font(.system(size:16, weight: .medium))
            .foregroundColor(fontColor)
            .padding(4)
            .background(bgColor)
            .cornerRadius(9)
    }
}

