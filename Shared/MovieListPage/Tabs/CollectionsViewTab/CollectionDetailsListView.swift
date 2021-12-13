//
//  CollectionDetailsListView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 4.12.2021.
//

import SwiftUI

struct CollectionDetailsListView: View {
    let title: String
    var movieIDs:[Int]
    
    @ObservedObject var viewModel = CollectionDetailsListViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack{
                ForEach(viewModel.collectedMovies, id:\.self){movie in
                    Divider()
                    NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie))) {
                        MovieCellView(image: movie.image, title: movie.title, releaseDate: movie.release_date)
                    }
                }
            }
        }
        .background(.black)
        .navigationBarColor(.black)
        .navigationTitle(title)
        .onAppear {
            viewModel.fetchMovies(movieIDs: movieIDs)
        }
    }
}

struct CollectionDetailsListView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionDetailsListView(title: "Test", movieIDs: [])
    }
}
