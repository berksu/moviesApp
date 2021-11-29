//
//  AllMoview.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 28.11.2021.
//

import SwiftUI

struct AllMoview: View {
    // 9 - Buradan gitmeli
    @ObservedObject var moviesViewModel: MovieListViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack{
                ForEach(moviesViewModel.searchResults.isEmpty ?  moviesViewModel.allMovies: moviesViewModel.searchResults, id: \.id) { movie in
                    VStack{
                        Divider()
                        MovieCell(movie: movie)
                        //Pagination
                        if(moviesViewModel.searchResults.isEmpty && self.moviesViewModel.allMovies.last?.id == movie.id){
                            Divider()
                            Text("Fetching more...")
                                .onAppear(perform: {
                                    // 10 - Burası metod olmalı sadece
                                    self.moviesViewModel.getTopMovies(pageNum: self.moviesViewModel.updateMovies())
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
        AllMoview(moviesViewModel: MovieListViewModel())
    }
}
