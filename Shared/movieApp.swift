//
//  movieApp.swift
//  Shared
//
//  Created by Berksu Kısmet on 10.11.2021.
//

import SwiftUI
import Firebase

@main
struct movieApp: App {
    init() {
        FirebaseApp.configure()
      }
    
    var body: some Scene {
        WindowGroup {
            LoginPageView()
        }
    }
}
