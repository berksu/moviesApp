//
//  MoviesListView.swift
//  movie
//
//  Created by Berksu Kısmet on 11.11.2021.
//

import SwiftUI
import Kingfisher

struct MainBackgroundView: View {
    @State var isSideMenuShow: Bool = false
    
    ////AppStorage and userdefaults tried
    //@AppStorage("tabSelection") private var selection: Int = 0
    ////@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    ////UserDefaults.standard.set(self.tapCount, forKey: "Tap")
    @StateObject var viewModel = MainBackgroundViewModel()
    
    var body: some View{
        NavigationView {
            ZStack{
                if(isSideMenuShow){
                    SideMenuView(isSideMenuShow: $isSideMenuShow)
                }
                tabBarView
                    .cornerRadius(isSideMenuShow ? 20 : 10)
                    .offset(x: isSideMenuShow ? 250:0, y: isSideMenuShow ? 50:0)
                    .scaleEffect(isSideMenuShow ? 0.8 : 1)
                    //.opacity(isSideMenuShow ? 0.4:1)
                    .ignoresSafeArea(.container, edges: .bottom)
                    .disabled(isSideMenuShow)
            }
            .navigationBarColor(.black)
            .background(.black)
            .ignoresSafeArea()
        }
    }
    
    var tabBarView: some View{
        TabView(selection: $viewModel.selection){
            allMoviesTab
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
            
            FavouritesView(searchResults: $viewModel.searchResults)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourites")
                }
                .tag(1)
            
            CollectionsView()
                .tabItem {
                    Image(systemName: "folder.fill")
                    Text("Collections")
                }
                .tag(2)
            
        }
        .searchable(text: $viewModel.searchMovie, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Movie").foregroundColor(.white)
        .onAppear {
                UITabBar.appearance().backgroundColor = .black
                UITabBar.appearance().unselectedItemTintColor = UIColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.75))
        }
        .accentColor(Color(red: 255/255, green: 178/255, blue: 36/255))
        .navigationTitle(viewModel.determineTheTitle(tabNo: viewModel.selection)) // bu satır constraint hatası verdiriyor
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    withAnimation(.spring()){
                        isSideMenuShow.toggle()
                    }
                } label: {
                    KFImage(URL(string: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .shadow(radius: 20)
                        .frame(height: 50)
                        .background(.clear)
                }
            }
        }
    }
    
    var allMoviesTab: some View{
        VStack(alignment: .leading){
            ScrollView{
                
                horizontalScrollView(title: "Latest", movieList: viewModel.latestMovies)

                horizontalScrollView(title: "Top Rated", movieList: viewModel.topRated)
                
                HStack{
                    Text(viewModel.searchResults.count == 0 ? "Popular":"Searched").padding(.top)
                        .foregroundColor(.white)
                    Spacer()
                    if(viewModel.searchResults.count != 0){
                        Button {
                            viewModel.searchResults = []
                            viewModel.searchMovie = ""
                        } label: {
                            Image(systemName: "arrow.clockwise.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }.padding(.top)
                    }
                }
                
                LazyVGrid(columns: [GridItem(), GridItem(),GridItem(),GridItem()]) {
                    ForEach(viewModel.searchResults.isEmpty ?  viewModel.allMovies: viewModel.searchResults, id: \.idForLoop) { movie in
                        NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie),genreList: $viewModel.genres).navigationBackButton(color: UIColor(Color(red: 255/255, green: 187/255, blue: 59/255)),
                                                                                                                                          text: "Back")) {
                            if let imageStr = movie.image{
                                KFImage.init(URL(string: "\(MovieListModel().urlBase)\(imageStr)"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }else{
                                Image("logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            
                        }
                        //Pagination
                        if(viewModel.searchResults.isEmpty && self.viewModel.allMovies.last?.id == movie.id){
                            Divider()
                            Text("Fetching more...")
                                .onAppear(perform: {
                                    self.viewModel.getTopMovies(pageNum: self.viewModel.pageNum)
                                })
                        }
                        else if(!viewModel.searchResults.isEmpty && viewModel.searchResults.last?.id == movie.id){
                            Divider()
                            //Text("Fetching more...")
                                .onAppear(perform: {
                                    self.viewModel.searchMovies(title: viewModel.searchMovie, page: viewModel.searched_pageNum)
                                    // self.allMoviewViewModel.searchMovies(title: <#T##String#>, completion: <#T##([Movie]) -> Void#>)
                                })
                        }
                    }
                }
            }
            
        }.background(.black)
    }
    
    func horizontalScrollView(title: String, movieList: [Movie]) -> some View{
        return Group{
        HStack{
            Text(title)
                .foregroundColor(.white)
            Spacer()
        }
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(movieList, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie),genreList: $viewModel.genres).navigationBackButton(color: UIColor(Color(red: 255/255, green: 187/255, blue: 59/255)),
                                                                                                                                text: "Back")) {
                        KFImage.init(URL(string: "\(MovieListModel().urlBase)\(movie.image ?? "")"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }.frame(height: 120)
        }
        }
    }
    
}


struct moviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MainBackgroundView()
    }
}




//@ObservedObject var viewModel = TabBackgroundViewModel()
//
//var body: some View {
//    TabView(selection: $selection){
//        AllMoviesView(searchResults: $viewModel.searchResults)
//            .tabItem {
//                Image(systemName: "house.fill")
//                Text("Home")
//            }.tag(0)
//        
//        FavouritesView(searchResults: $viewModel.searchResults)
//            .tabItem {
//                Image(systemName: "heart.fill")
//                Text("Favourites")
//            }
//            .tag(1)
//        
//        CollectionsView()
//            .tabItem {
//                Image(systemName: "folder.fill")
//                Text("Collections")
//            }
//            .tag(2)
//        
//    }
//    .searchable(text: $viewModel.searchMovie, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Movie").foregroundColor(.white)
//    .onAppear {
//        UITabBar.appearance().backgroundColor = .black
//        UITabBar.appearance().unselectedItemTintColor = UIColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.75))
//    }
//    .accentColor(Color(red: 255/255, green: 178/255, blue: 36/255))
//   // .searchable(text: $viewModel.searchMovie, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Movie")
//    .navigationTitle(viewModel.determineTheTitle(tabNo: selection)) // bu satır constraint hatası verdiriyor
//    // 3 principal
//    .toolbar{
//        //            ToolbarItem(placement: .principal) {
//        //                Text(selection == 0 ? "Top \(moviesViewModel.allMovies.count) Movies": "Favourite Movies")
//        //            }
//        ToolbarItem(placement: .navigationBarLeading) {
//            Button {
//                withAnimation(.spring()){
//                    isSideMenuShow.toggle()
//                }
//            } label: {
//                KFImage(URL(string: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"))
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .clipShape(Circle())
//                    .shadow(radius: 20)
//                    .frame(height: 50)
//                    .background(.clear)
//            }
//        }
//    }
//}
