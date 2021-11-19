//
//  test.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 16.11.2021.
//

import SwiftUI

struct CardMenuView: View {
    @ObservedObject var cardMenuViewModel: CardMenuViewModel
    var categories: [CardMenuCategories] = [CardMenuCategories(categoryName: "drama"),
                                            CardMenuCategories(categoryName: "action"),
                                            CardMenuCategories(categoryName: "love"),
                                            CardMenuCategories(categoryName: "drama2"),
                                            CardMenuCategories(categoryName: "action2"),
                                            CardMenuCategories(categoryName: "love2"),
                                            CardMenuCategories(categoryName: "drama3"),
                                            CardMenuCategories(categoryName: "action3"),
                                            CardMenuCategories(categoryName: "love3")]
    
    @State var offset_val = CGSize.zero
    
    //@State private var cards = [Card](repeating: Card.example, count: 10)
    @State private var cards = [Card.example1, Card.example2, Card.example3, Card.example4, Card.example5]
    
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
            //Gözden geçirilecek
            ZStack(){
                ForEach(0..<cards.count, id: \.self) { index in
                    if(index > cards.count - 4){
                        CardView(card: self.cards[index]){
                            withAnimation{
                                if(index != 0){
                                    cards[index-1].isDraggable = true
                                }
                                removeCard(at: index)
                            }
                        }
                        .stacked(at: index > 2 ? 2:index, in: (cards.count > 3) ? 3:cards.count)
                        .opaced(at: index > 2 ? 2:index, in: (cards.count > 3) ? 3:cards.count)
                        .scaled(at: index > 2 ? 2:index, in: (cards.count > 3) ? 3:cards.count)
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    
    func singleCardView(offset_x: CGFloat, opacity: CGFloat, scaleRate: CGFloat, geometry:GeometryProxy ) -> some View {
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
    
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
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
        CardMenuView(cardMenuViewModel: CardMenuViewModel())
    }
}


extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position + 1)
        return self.offset(CGSize(width: offset * 20, height: 0))
    }
    
    func opaced(at position: Int, in total: Int) -> some View {
        if(position == total - 1){
            return self.opacity(1)
        }
        return self.opacity(0.2)
    }
    
    func scaled(at position: Int, in total: Int) -> some View {
        switch position{
        case 0:
            return self.scaleEffect(0.9)
        case 1:
            return self.scaleEffect(0.95)
        default:
            return self.scaleEffect(1)
        }
    }
}


