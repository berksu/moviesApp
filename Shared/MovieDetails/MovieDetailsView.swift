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
    
    @State var isSideMenuShow = false
    @Binding var genreList:[Genre]
    
    var body: some View{
        GeometryReader{geometry in
            VStack{
                imageView(geometry: geometry)
                title
                movieInfoView
                    .padding()
                scrolledTextView(genreStruct: $viewModel.genreStruct)
                headerView(geometry: geometry)
                Spacer()
            }
            //.navigationBarHidden(true)
            .background(.black)
            .ignoresSafeArea()
        }
        .onAppear(perform: {
            if let genreIDS = viewModel.movie.genreIDs{
                viewModel.getGenreStrings(genreInt: genreIDS, genres: genreList)
            }
        })
        .sheet(isPresented: $viewModel.isAddMovieToCollectionButtonTapped, onDismiss: {
            viewModel.addMovieToCollectionButton(state: false)
        }, content: {
            MovieToCollectionView(movieID: viewModel.movie.id)
        })
    }

    func imageView(geometry: GeometryProxy) -> some View{
        return ScrollView{
            ZStack(alignment: .topLeading){
                if let im = viewModel.movie.backdropPath{
                    KFImage.init(URL(string: "https://www.themoviedb.org/t/p/w1280\(im)"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * 1.5)
                        .overlay(
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(LinearGradient(gradient: Gradient(colors: [.clear, Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.8)]), startPoint: .center, endPoint: .bottom))
                        )
                }else{
                    ZStack{
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.5)
                            .padding(.top)
                    }.frame(width: geometry.size.width * 1.5, height: geometry.size.height * 0.45)
                    
                }
                
//                NavigationLink(destination: MainBackgroundView().navigationBarHidden(true)){
//                    Text("< Back")
//                        .foregroundColor(.yellow)
//                        .padding(EdgeInsets(top: geometry.size.height * 0.05, leading: geometry.size.width * 0.3, bottom: 0, trailing: 0))
//                }
            }
        }.frame(width: geometry.size.width, height: geometry.size.height * 0.45)
    }
    
    var title: some View{
        Text(viewModel.movie.title ?? "")
            .font(.title)
            .fontWeight(.semibold)
            .lineLimit(2)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.white.opacity(0.8))
    }
    
    var movieInfoView: some View{
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
    }
    
    
    func headerView(geometry: GeometryProxy) -> some View {
        return VStack{
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
            }.padding(.bottom)
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
    
    struct scrolledTextView: View{
        @Binding var genreStruct: [GenreWithId]
        
        var body: some View{
            HStack(spacing: 10){
                ForEach(genreStruct, id: \.id){ genre in
                    Text(genre.name)
                        .font(.subheadline)
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.8)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .stroke(Color.white, lineWidth: 2)
                                .frame(height: 20)
                        )
                }
            }.padding(.leading)
                .frame(height:25)
        }
    }
}


//struct MovieDetailsView: View {
//    @ObservedObject var viewModel: MovieDetailsViewModel
//
//    var body: some View{
//        //NavigationView {
//            VStack(spacing:20){
//                Spacer()
//                headerView
//                titleView
//                    .padding()
//                Spacer()
//            }
//            .navigationBarColor(.black)
//            .background(.black)
//            .navigationBarTitleDisplayMode(.inline)
//        //}
//        .sheet(isPresented: $viewModel.isAddMovieToCollectionButtonTapped, onDismiss: {
//            viewModel.addMovieToCollectionButton(state: false)
//        }, content: {
//            MovieToCollectionView(movieID: viewModel.movie.id)
//        })
//    }
//
//    var headerView: some View {
//        GeometryReader{ geometry in
//            VStack{
//
//                if let im = viewModel.movie.image{
//                    KFImage(URL(string: "https://www.themoviedb.org/t/p/w1280\(im)"))
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: geometry.size.height)
//                        .cornerRadius(4)
//                        .padding(.vertical, 4)
//                        .shadow(color: .white, radius: 2)
//                }else{
//                    KFImage(URL(string: ""))
//                        .frame(height: geometry.size.height)
//                }
//
//                HStack{
//                    Image(systemName: "hand.thumbsup")
//                        .foregroundColor(.white)
//                    if let vote = viewModel.movie.voteAverage{
//                        Text("\(vote, specifier: "%.2f")" )
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                    }else{
//                        Text("rating")
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                    }
//
//                    Image(systemName: "eye")
//                        .foregroundColor(.white)
//                        .padding(.leading,40)
//                    if let vote_count = viewModel.movie.voteCount{
//                        Text("\(Int(vote_count))" )
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                    }else{
//                        Text("count")
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                    }
//
//                    Button {
//                        viewModel.movieFavouriteStatusUpdate()
//                        if(viewModel.isFavourite == false){
//                            viewModel.removeFromDatabase()
//                        }else{
//                            viewModel.addToDatabase()
//
//                        }
//                    } label: {
//                        Image(systemName: viewModel.isFavourite ? "heart.fill" : "heart")
//                            .foregroundColor(viewModel.isFavourite ? .red : .white)
//                            .padding(.leading,40)
//                    }.onAppear {
//                        viewModel.isInFavourite()
//                    }
//
//                    addMovieToCollectionButton
//
//                }
//            }.frame(width: geometry.size.width, height: geometry.size.height)
//        }
//
//    }
//
//
//    var titleView: some View{
//        GeometryReader{ geometry in
//            VStack{
//                Text(viewModel.movie.title ?? "")
//                    .font(.title)
//                    .fontWeight(.semibold)
//                    .lineLimit(2)
//                    .minimumScaleFactor(0.5)
//                    .padding()
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(.white)
//
//                if let release_date = viewModel.movie.release_date {
//                    Text(release_date[0..<4])
//                        .font(.subheadline)
//                        .foregroundColor(.white)
//                }else{
//                    Text("")
//                }
//
//                ScrollView(showsIndicators: false){
//                    Text(viewModel.movie.overview ?? "")
//                        .font(.subheadline)
//                        .foregroundColor(.white)
//                        //.minimumScaleFactor(0.6)
//                        .lineLimit(nil)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .frame(width: geometry.size.width*0.9)
//                }
//
//            }.frame(width: geometry.size.width, height: geometry.size.height)
//        }
//    }
//
//
//    var addMovieToCollectionButton: some View{
//        Button {
//            viewModel.addMovieToCollectionButton(state: true)
//        } label: {
//            Image(systemName: "folder.badge.plus")
//                .foregroundColor(.white)
//                .padding(.leading,40)
//        }
//
//    }
//}


struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: MovieDetailsViewModel(movie: Movie(id: 99999999, title: "Dexter", release_date: "2003", image: "https://tr.web.img4.acsta.net/pictures/21/10/04/15/10/2211034.jpg", voteAverage: 9.1, voteCount: 3245, overview: "dexter is a tv series", backdropPath: "", genreIDs:[])),genreList: .constant([]))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}

