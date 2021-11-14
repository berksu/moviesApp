//
//  MovieDetailsView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 14.11.2021.
//


import SwiftUI
import Kingfisher


struct MovieDetailsView: View {
        
    var movie: Movie
    
    var body: some View{
        NavigationView {
            VStack(spacing:10){
                KFImage(URL(string: movie.image ?? "")!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(4)
                    .padding(.vertical, 4)
                
            
                HStack{
                    Image(systemName: "hand.thumbsup")
                        .foregroundColor(.secondary)
                    Text(movie.imDbRating ?? "rating")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    

                    Image(systemName: "eye")
                        .foregroundColor(.secondary)
                        .padding(.leading,40)
                    Text(movie.ratingCount ?? "count")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text(movie.title ?? "")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .padding(.top,30)
                    
                Text(movie.year ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                    .frame(height:175)
            }
            
            
        }
        
    }
    
}





struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: Movie(id: "asd", title: "Dexter", year: "2003", image: "https://tr.web.img4.acsta.net/pictures/21/10/04/15/10/2211034.jpg", imDbRating: "9.1", ratingCount: "30000"))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}

