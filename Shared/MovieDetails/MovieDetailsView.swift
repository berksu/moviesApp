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
        //NavigationView {
            VStack(spacing:20){
                Spacer()
                headerView
                titleView
                    .padding()
                Spacer()
            }
            .navigationBarColor(.black)
            .background(.black)
            .navigationBarTitleDisplayMode(.inline)
        //}
        .sheet(isPresented: $viewModel.isAddMovieToCollectionButtonTapped, onDismiss: {
            viewModel.addMovieToCollectionButton(state: false)
        }, content: {
            MovieToCollectionView(movieID: viewModel.movie.id)
        })
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
                        .shadow(color: .white, radius: 2)
                }else{
                    KFImage(URL(string: ""))
                        .frame(height: geometry.size.height)
                }
                
                HStack{
                    Image(systemName: "hand.thumbsup")
                        .foregroundColor(.white)
                    if let vote = viewModel.movie.voteAverage{
                        Text("\(vote, specifier: "%.2f")" )
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }else{
                        Text("rating")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                        
                    Image(systemName: "eye")
                        .foregroundColor(.white)
                        .padding(.leading,40)
                    if let vote_count = viewModel.movie.voteCount{
                        Text("\(Int(vote_count))" )
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }else{
                        Text("count")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    
                    Button {
                        viewModel.movieFavouriteStatusUpdate()
                        if(viewModel.isFavourite == false){
                            viewModel.removeFromDatabase()
                        }else{
                            viewModel.addToDatabase()

                        }
                    } label: {
                        Image(systemName: viewModel.isFavourite ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.isFavourite ? .red : .white)
                            .padding(.leading,40)
                    }.onAppear {
                        viewModel.isInFavourite()
                    }
                    
                    addMovieToCollectionButton

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
                    .foregroundColor(.white)
                
                if let release_date = viewModel.movie.release_date {
                    Text(release_date[0..<4])
                        .font(.subheadline)
                        .foregroundColor(.white)
                }else{
                    Text("")
                }
                
                ScrollView(showsIndicators: false){
                    Text(viewModel.movie.overview ?? "")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        //.minimumScaleFactor(0.6)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: geometry.size.width*0.9)
                }
                
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    
    var addMovieToCollectionButton: some View{
        Button {
            viewModel.addMovieToCollectionButton(state: true)
        } label: {
            Image(systemName: "folder.badge.plus")
                .foregroundColor(.white)
                .padding(.leading,40)
        }

    }
}


struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: MovieDetailsViewModel(movie: Movie(id: 99999999, title: "Dexter", release_date: "2003", image: "https://tr.web.img4.acsta.net/pictures/21/10/04/15/10/2211034.jpg", voteAverage: 9.1, voteCount: 3245, overview: "dexter is a tv series")))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}

