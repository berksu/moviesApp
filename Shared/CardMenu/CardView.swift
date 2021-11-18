////
////  CardView.swift
////  movie (iOS)
////
////  Created by Berksu Kısmet on 18.11.2021.
////
//
import SwiftUI
//
//struct CardView: View {
//    @State var offset_x: CGFloat
//    @State var opacity_v: CGFloat
//    @State var scaleRate: CGFloat
//    //@State var geometry: GeometryProxy
//
//    @State var text: String? = ""
//    var body: some View {
//        ZStack{
//            RoundedRectangle(cornerRadius: 30)
//                .foregroundColor(.red)
//                .overlay(RoundedRectangle(cornerRadius: 30)
//                            .strokeBorder(.black,lineWidth: 5))
//                //.frame(width: geometry.size.width*0.75,
//                //       height: geometry.size.height*0.8)
//                //.offset(x:offset_x,y:0)
//                .opacity(opacity_v)
//                .scaleEffect(scaleRate)
//
//            Text(text ?? "null")
//        }
//
//    }
//}


struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil
    
    @State private var offset = CGSize.zero
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.red)
                    .overlay(RoundedRectangle(cornerRadius: 30)
                                .strokeBorder(.black,lineWidth: 5))
                    .frame(width: geometry.size.width*0.75,
                           height: geometry.size.height*0.8)
                    .rotationEffect(.degrees(Double(offset.width / 5)))
                    .offset(x: offset.width * 5, y: 0)
                    .opacity(2-Double(abs(offset.width / 50)))
                    .gesture(
                        DragGesture()
                            .onChanged{ gesture in
                                withAnimation(.spring()){
                                    self.offset = self.card.isDraggable ? gesture.translation:self.offset
                                }
                            }
                            .onEnded{ _ in
                                if(abs(self.offset.width) > 100){
                                    self.removal?()
                                }else{
                                    withAnimation(.spring()){
                                        self.offset = .zero
                                    }
                                }
                            }
                    )
                
                Text(card.prompt)
                    .rotationEffect(.degrees(Double(offset.width / 5)))
                    .offset(x: offset.width * 5, y: 0)
                    .opacity(2-Double(abs(offset.width / 50)))
                
                
            }
        }
    }
}
