//
//  MovieToCollectionListItemView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 5.12.2021.
//

import SwiftUI

struct MovieToCollectionListItemView: View {
    var collection: CollectionModel
    let movieID: Int
    
    @ObservedObject var viewModel = MovieToCollectionListItemViewModel()
    
    var body: some View {
        HStack{
            Text(collection.title ?? "")
                .padding(.top)
            Spacer()
            Image(systemName: viewModel.isCellTapped ? "plus.square.fill.on.square.fill": "plus.square.on.square")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
        }.padding()
            .onTapGesture {
                viewModel.isCellButtonTapped()                
                viewModel.updateCollection(collection: collection, movieID: movieID)
            }
            .onAppear {
                viewModel.controlIsMovieInCollection(movieIDs: collection.movieIDs ?? [],
                                                movieID: movieID)
            }
    }
}

struct MovieToCollectionListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieToCollectionListItemView(collection: CollectionModel(id: "test", title: "test", movieIDs: [1]), movieID: 1)
    }
}
