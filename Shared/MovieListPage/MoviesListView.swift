//
//  MoviesListView.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import SwiftUI
import Kingfisher

struct MoviesListView: View {
    

    @ObservedObject var moviesViewModel = MovieListViewModel()
    
    var movies_all : [Movie] {
            get {
             return moviesViewModel.topTwo
            }
        }
    
    var body: some View{
        NavigationView {
            List (movies_all, id: \.id){ movie in
                movieCell(movie: movie)
            }
            .navigationTitle("Top 50 Movies")
        }.navigationBarHidden(true)
        
    }
}





struct movieCell: View{
    var movie: Movie
    
    var body: some View{
        HStack{
            KFImage(URL(string: movie.movieImage)!)
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .cornerRadius(4)
                .padding(.vertical, 4)
            
        
            VStack(alignment: .leading, spacing: 2){
                Text(movie.movieName)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                
                Text(movie.movieDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
        }
    }
}



struct moviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(moviesViewModel: .init())
    }
}

