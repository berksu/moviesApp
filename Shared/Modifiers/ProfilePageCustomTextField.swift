//
//  ProfilePageCustomTextField.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 28.11.2021.
//

import SwiftUI

struct ProfilePageCustomTextField: ViewModifier{
    let geometry: GeometryProxy
    
    func body(content: Content) -> some View{
        return content
            .frame(width: geometry.size.width*0.5)
            .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(.black)))
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
}
