//
//  navigationViewExtension.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 12.12.2021.
//

import SwiftUI

extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }

}
