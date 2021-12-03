//
//  CollectionCellView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 3.12.2021.
//

import SwiftUI

struct CollectionCellView: View {
    var body: some View {
        HStack(){
            Image(systemName: "folder")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
            
            Text("asd")
                .padding(.leading)
            
            Spacer()
        }
        .padding()
    }
}

struct CollectionCellView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionCellView()
    }
}
