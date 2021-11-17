//
//  test.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 16.11.2021.
//

import SwiftUI

struct cardMenuView: View {
    //@ObservedObject var cardMenuViewModel: CardMenuViewModel
    var categories: [CardMenuCategories] = [CardMenuCategories(categoryName: "drama"),
                                            CardMenuCategories(categoryName: "action"),
                                            CardMenuCategories(categoryName: "love"),
                                            CardMenuCategories(categoryName: "drama2"),
                                            CardMenuCategories(categoryName: "action2"),
                                            CardMenuCategories(categoryName: "love2"),
                                            CardMenuCategories(categoryName: "drama3"),
                                            CardMenuCategories(categoryName: "action3"),
                                            CardMenuCategories(categoryName: "love3")]
    var body: some View {
        NavigationView{
            VStack{
                scrolledTextView(categories: categories)
                    .padding(.top)
                cardsView
                    .padding()
                buttonsSection
                    .padding()
            }
            .navigationTitle("Çakma Clyx")
        }
        .navigationBarHidden(true)
    }
    
    var cardsView: some View {
        GeometryReader { geometry in
            ZStack(){
                singleCardView(offset_x: 40, opacity: 0.2, scaleRate: 0.9, geometry: geometry)
                singleCardView(offset_x: 20, opacity: 0.4, scaleRate: 0.95, geometry: geometry)
                singleCardView(offset_x: 0, opacity: 1, scaleRate: 1, geometry: geometry)
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    func singleCardView(offset_x: CGFloat, opacity: CGFloat, scaleRate: CGFloat, geometry:GeometryProxy) -> some View {
        RoundedRectangle(cornerRadius: 30)
            .foregroundColor(.red)
            .overlay(RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.black,lineWidth: 5))
            .frame(width: geometry.size.width*0.75,
                   height: geometry.size.height*0.8)
            .offset(x:offset_x,y:0)
            .opacity(opacity)
            .scaleEffect(scaleRate)
    }
    
    var buttonsSection: some View {
        HStack(spacing:50){
            buttonView(imageName: "mic.slash")
            buttonView(imageName: "bubble.left")
            buttonView(imageName: "phone")
        }
    }
    
}

struct buttonView:View{
    @State var imageName: String
    var body: some View{
        Button {
            print("\(imageName)")
        } label: {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
        }
        
    }
}




struct scrolledTextView: View{
    
    @State var categories: [CardMenuCategories]
    
    var body: some View{
        ScrollView(.horizontal,showsIndicators: false){
            LazyHStack(spacing: 10){
                ForEach(categories, id: \.self){ category in
                    Text(category.categoryName)
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .foregroundColor(.black)
                        .minimumScaleFactor(0.8)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
            }.padding(.leading)
        }.frame(height: 40)
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        cardMenuView()
    }
}
