//
//  MovieDetailsView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 14.11.2021.
//


import SwiftUI
import Kingfisher


struct MovieDetailsView: View {
    
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View{
        NavigationView {
            VStack(spacing:30){
                headerView
                titleView
            }.padding(.bottom, 100)
        }
    }
    
    
    var headerView: some View {
        VStack{
            KFImage(URL(string: viewModel.movie.image ?? "")!)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .cornerRadius(4)
                .padding(.vertical, 4)
            
            
            HStack{
                Image(systemName: "hand.thumbsup")
                    .foregroundColor(.secondary)
                Text(viewModel.movie.imDbRating ?? "rating")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                
                Image(systemName: "eye")
                    .foregroundColor(.secondary)
                    .padding(.leading,40)
                Text(viewModel.movie.ratingCount ?? "count")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    
    var titleView: some View{
        VStack{
            Text(viewModel.movie.title ?? "")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .padding(.top,30)
            
            Text(viewModel.movie.year ?? "")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    
}





struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: MovieDetailsViewModel(movie: Movie(id: "asd", title: "Dexter", year: "2003", image: "https://tr.web.img4.acsta.net/pictures/21/10/04/15/10/2211034.jpg", imDbRating: "9.1", ratingCount: "30000")))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}

