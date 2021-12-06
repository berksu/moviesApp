//
//  MovieToCollectionView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 5.12.2021.
//

import SwiftUI

struct MovieToCollectionView: View {
    @ObservedObject var viewModel = MovieToCollectionViewModel()
    var movieID: Int
    
    var body: some View {
        VStack{
            Text("Collections")
                .font(.system(size:20, weight: .bold))
                .background()
                .padding()
            List{
                ForEach(viewModel.collections, id: \.id){ collection in
                    MovieToCollectionListItemView(collection: collection, movieID: movieID)
                }
            }
        }
    }
        
}

struct MovieToCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieToCollectionView(movieID: 1)
    }
}
