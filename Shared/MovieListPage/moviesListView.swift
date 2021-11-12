//
//  moviesListView.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import SwiftUI


struct moviesListView: View {
    
    var movies:[Movie] = movieList.topTwo
    
    var body: some View{
        NavigationView {
            List (movies, id: \.id){ movie in
                movieCell(movie: movie)
            }
            .navigationTitle("Top 100 Movies")
        }.navigationBarHidden(true)
        
    }
}





struct movieCell: View{
    var movie: Movie
    
    var body: some View{
        HStack{
            Image(movie.movieImage)
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
        moviesListView()
    }
}

