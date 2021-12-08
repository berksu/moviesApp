//
//  AllMoview.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 28.11.2021.
//

import SwiftUI

struct AllMoviesView: View {
    @ObservedObject var allMoviewViewModel = AllMoviesViewModel()
    @Binding var searchResults: [Movie]
    
    @State var temp = ""
    
    var body: some View {
        VStack{
            Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: 30)
            .background(.red)
            .padding()
            
            ScrollView(showsIndicators: false){
                LazyVStack{
                    ForEach(searchResults.isEmpty ?  allMoviewViewModel.allMovies: searchResults, id: \.id) { movie in
                        VStack{
                            Divider()
                            NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie))) {
                                MovieCellView(image: movie.image, title: movie.title, releaseDate: movie.release_date)
                                    .redacted(reason: .placeholder)
                            }
                            //Pagination
                            if(searchResults.isEmpty && self.allMoviewViewModel.allMovies.last?.id == movie.id){
                                Divider()
                                Text("Fetching more...")
                                    .onAppear(perform: {
                                        self.allMoviewViewModel.getTopMovies(pageNum: self.allMoviewViewModel.pageNum)
                                    })
                            }
    //                        else if(!searchResults.isEmpty && searchResults.last?.id == movie.id){
    //                            Divider()
    //                            Text("Fetching more...")
    //                                .onAppear(perform: {
    //                                    //self.allMoviewViewModel.getTopMovies(pageNum: self.allMoviewViewModel.pageNum)
    //                                })
    //                        }
                        }
                    }
                }
            }
        }
    }
}

struct AllMoview_Previews: PreviewProvider {
    static var previews: some View {
        AllMoviesView(searchResults: .constant([Movie(id: 1, title: "test", release_date: "test", image: "test", voteAverage: 3.2, voteCount: 1234, overview: "ads")]))
    }
}
