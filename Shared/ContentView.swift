//
//  ContentView.swift
//  Shared
//
//  Created by Berksu Kısmet on 10.11.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Movies !!!!")
                .padding()
            userNameView()
            passwordView()
            Spacer()
        }
    }
}


struct userNameView: View{
    @State var mail = ""
    
    var body: some View{
        GeometryReader { geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 20.0).foregroundColor(.red).opacity(0.7)
                TextField("Username", text: self.$mail)
                    .padding()
                    .foregroundColor(.white)
            }.frame(width: geometry.size.width*0.9, height: 50, alignment: .center)
                .padding()
        }.frame(height:60)
    }
}


struct passwordView: View{
    @State var password = ""
    
    var body: some View{
        GeometryReader { geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 20.0).foregroundColor(.red).opacity(0.7)
                TextField("Password", text: self.$password)
                    .padding()
                    .foregroundColor(.white)
            }.frame(width: geometry.size.width*0.9, height: 50, alignment: .center)
                .padding()
        }.frame(height:60)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
