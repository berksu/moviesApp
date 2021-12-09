//
//  AllMoview.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 28.11.2021.
//

import SwiftUI
import Kingfisher

struct AllMoviesView: View {
    @ObservedObject var allMoviewViewModel = AllMoviesViewModel()
    @Binding var searchResults: [Movie]
    
    @State var temp = ""
    
    var body: some View {
        //GeometryReader{geometry in
        ScrollView{
            LazyVGrid(columns: [GridItem(), GridItem(),GridItem()]) {
                ForEach(searchResults.isEmpty ?  allMoviewViewModel.allMovies: searchResults, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie))) {
                        KFImage.url(URL(string: "\(MovieListModel().urlBase)\(movie.image ?? "")"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
        }
        .background(.black)
        
    }
    
}

struct AllMoview_Previews: PreviewProvider {
    static var previews: some View {
        AllMoviesView(searchResults: .constant([Movie(id: 1, title: "test", release_date: "test", image: "test", voteAverage: 3.2, voteCount: 1234, overview: "ads")]))
    }
}




//struct AllMoviesView: View {
//    @ObservedObject var allMoviewViewModel = AllMoviesViewModel()
//    @Binding var searchResults: [Movie]
//
//    @State var temp = ""
//
//    var body: some View {
//        VStack{
//            ScrollView(showsIndicators: false){
//                LazyVStack{
//                    ForEach(searchResults.isEmpty ?  allMoviewViewModel.allMovies: searchResults, id: \.id) { movie in
//                        VStack{
//                            Divider()
//                            NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie))) {
//                                MovieCellView(image: movie.image, title: movie.title, releaseDate: movie.release_date)
//                                    //.redacted(reason: .placeholder)
//                            }
//                            //Pagination
//                            if(searchResults.isEmpty && self.allMoviewViewModel.allMovies.last?.id == movie.id){
//                                Divider()
//                                Text("Fetching more...")
//                                    .onAppear(perform: {
//                                        self.allMoviewViewModel.getTopMovies(pageNum: self.allMoviewViewModel.pageNum)
//                                    })
//                            }
//    //                        else if(!searchResults.isEmpty && searchResults.last?.id == movie.id){
//    //                            Divider()
//    //                            Text("Fetching more...")
//    //                                .onAppear(perform: {
//    //                                    //self.allMoviewViewModel.getTopMovies(pageNum: self.allMoviewViewModel.pageNum)
//    //                                })
//    //                        }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
