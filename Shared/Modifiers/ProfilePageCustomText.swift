//
//  ProfilePageCustomText.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 28.11.2021.
//

import SwiftUI

struct ProfilePageCustomText: ViewModifier{
    let geometry: GeometryProxy
    
    func body(content: Content) -> some View{
        return content
            .font(.system(size:16, weight: .medium))
            .foregroundColor(Color(.black))
            .cornerRadius(16)
            .frame(width: geometry.size.width*0.2,alignment: .leading)
            .padding()
    }
}
