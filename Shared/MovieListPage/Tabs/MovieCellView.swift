//
//  MovieCellView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 28.11.2021.
//

import SwiftUI
import Kingfisher

struct MovieCellView: View{
    let movieCellViewModel = MovieCellViewModel()
    
    let image: String?
    let title: String?
    let releaseDate: String?
    
    var body: some View {
        HStack(spacing: 20){
            KFImage.url(URL(string: "\(MovieListModel().urlBase)\(image ?? "")"))
                .placeholder({
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .cornerRadius(4)
                        .padding(.vertical, 4)
                })
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .cornerRadius(4)
                .padding(.vertical, 4)
            
            VStack(alignment: .leading, spacing: 2){
                Text(title ?? "")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.leading)
                
                if let movieReleaseDate = releaseDate{
                    Text(movieCellViewModel.getYearFromRelaseDate(releaseDate: movieReleaseDate))
                        .font(.subheadline)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8))
                }else{
                    Text("")
                }
            }
            Spacer()
        }
        .padding(.leading)
    }
}


struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCellView(image: nil, title: "Test", releaseDate: "1992")
    }
}
