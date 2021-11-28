//
//  MovieCell.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 28.11.2021.
//

import SwiftUI
import Kingfisher

struct MovieCell: View{
    var movie: Movie
    
    var body: some View{
        NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie))) {
            HStack(spacing: 20){
                if let im = movie.image{
                    KFImage(URL(string: "\(MovieListModel().urlBase)\(im)"))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                        .cornerRadius(4)
                        .padding(.vertical, 4)
                }else{
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .background(.black)
                        .frame(height: 40)
                        .cornerRadius(4)
                        .padding(.vertical, 4)
                }
                
                VStack(alignment: .leading, spacing: 2){
                    Text(movie.title ?? "")
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.leading)
                    
                    if let release_date = movie.release_date{
                        Text(release_date[0..<4])
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }else{
                        Text("")
                    }
                }
                Spacer()
            }.padding(.leading)
        }
        
    }
}


struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(movie: Movie(id: 999999, title: "test", release_date: "test", image: "test", vote_average: 9.2, vote_count: 36321, overview: "test"))
    }
}
