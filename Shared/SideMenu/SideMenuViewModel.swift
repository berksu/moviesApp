//
//  SideMenuModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 16.11.2021.
//

import Foundation
import Firebase

enum SideMenuViewModel: Int, CaseIterable{
    case profile
    case logout
    
    var title: String{
        switch self{
        case .profile: return "Profile"
        case .logout: return "Logout"
        }
    }
    
    var imageName: String{
        switch self{
        case .profile: return "person"
        case .logout: return "chevron.backward.square"
        }
    }
}


final class SideMenuViewModell: ObservableObject{
    func logout()->Bool{
        return AuthenticationApi().logOut()
    }
}
