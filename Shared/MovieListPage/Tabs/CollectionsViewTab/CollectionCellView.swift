//
//  CollectionCellView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 3.12.2021.
//

import SwiftUI

struct CollectionCellView: View {
    let collectionName: String
    
    var body: some View {
        HStack(){
            Image(systemName: "folder")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8))
                .frame(width: 30)
            
            Text(collectionName)
                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8))
                .padding(.leading)
            
            Spacer()
        }
        .padding()
    }
}

struct CollectionCellView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionCellView(collectionName: "test")
    }
}
