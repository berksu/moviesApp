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
                    .padding()
                Spacer()
            }
            .navigationBarHidden(true)
        }
            
    }
    
    
    var headerView: some View {
        GeometryReader{ geometry in
            VStack{
                
                if let im = viewModel.movie.image{
                    KFImage(URL(string: "https://www.themoviedb.org/t/p/w1280\(im)"))
                        .resizable()
                        .scaledToFit()
                        .frame(height: geometry.size.height)
                        .cornerRadius(4)
                        .padding(.vertical, 4)
                }else{
                    KFImage(URL(string: ""))
                        .frame(height: geometry.size.height)
                }
                
                
                HStack{
                    Image(systemName: "hand.thumbsup")
                        .foregroundColor(.secondary)
                    if let vote = viewModel.movie.vote_average{
                        Text("\(vote, specifier: "%.2f")" )
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }else{
                        Text("rating")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                        
                    
                    
                    Image(systemName: "eye")
                        .foregroundColor(.secondary)
                        .padding(.leading,40)
                    if let vote_count = viewModel.movie.vote_count{
                        Text("\(Int(vote_count))" )
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }else{
                        Text("count")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    
                    Button {
                        viewModel.movie.isFavourite.toggle()
                        if(viewModel.movie.isFavourite == false){
                            viewModel.removeToDatabase()
                        }else{
                            viewModel.addToDatabase()

                        }
                    } label: {
                        Image(systemName: viewModel.movie.isFavourite ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.movie.isFavourite ? .red : .secondary)
                            .padding(.leading,40)
                    }

                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }

    }
    
    
    var titleView: some View{
        GeometryReader{ geometry in
            VStack{
                Text(viewModel.movie.title ?? "")
                    .font(.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .padding()
                    .multilineTextAlignment(.center)
                
                if let release_date = viewModel.movie.release_date {
                    Text(release_date[0..<4])
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }else{
                    Text("")
                }
                
                ScrollView(showsIndicators: false){
                    Text(viewModel.movie.overview ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        //.minimumScaleFactor(0.6)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: geometry.size.width*0.9)
                }
                
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    
}





struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: MovieDetailsViewModel(movie: Movie(id: 99999999, title: "Dexter", release_date: "2003", image: "https://tr.web.img4.acsta.net/pictures/21/10/04/15/10/2211034.jpg", vote_average: 9.1, vote_count: 3245, overview: "dexter is a tv series")))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}

