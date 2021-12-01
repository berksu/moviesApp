//
//  AllMoview.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 28.11.2021.
//

import SwiftUI

struct AllMoviesView: View {
    // 9 - Buradan gitmeli
    //@ObservedObject var moviesViewModel: MainBackgroundViewModel
    @ObservedObject var allMoviewViewModel = AllMoviesViewModel()

    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack{
                //ForEach(moviesViewModel.searchResults.isEmpty ?  moviesViewModel.allMovies: moviesViewModel.searchResults, id: \.id) { movie in
                ForEach(allMoviewViewModel.allMovies , id: \.id) { movie in
                    VStack{
                        Divider()
                        NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie))) {
                            MovieCellView(image: movie.image, title: movie.title, releaseDate: movie.release_date)
                        }
                        //Pagination
                        //if(moviesViewModel.searchResults.isEmpty && self.moviesViewModel.allMovies.last?.id == movie.id){
                        if(self.allMoviewViewModel.allMovies.last?.id == movie.id){
                            Divider()
                            Text("Fetching more...")
                                .onAppear(perform: {
                                    // 10 - Burası metod olmalı sadece
                                    self.allMoviewViewModel.getTopMovies(pageNum: self.allMoviewViewModel.updateMovies())
                                })
                        }
                    }
                }
            }
        }.listStyle(PlainListStyle())
    }
}

struct AllMoview_Previews: PreviewProvider {
    static var previews: some View {
        AllMoviesView()
    }
}
