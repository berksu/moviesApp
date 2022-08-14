//
//  AddCollectionView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 3.12.2021.
//

import SwiftUI

struct AddCollectionView: View {
    @ObservedObject var addCollectionViewModel = AddCollectionViewModel()
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack{
//            HStack{
//                Spacer()
//                closeButton
//                    .padding()
//            }
            Spacer()

            ZStack{
                Circle()
                    .foregroundColor(.black)
                    .overlay(Circle().stroke(.white ,lineWidth: 3))
                    .frame(width: 150, height: 150)
                
                Image(systemName: "folder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
            }
            
            collectionName
                .padding(.top,40)
            
            addButton
                .padding(.top)
            Spacer()
        }
        .background(.black)
    }
    
    var collectionName: some View {
        TextField("Name of Collection", text: $addCollectionViewModel.collectionNameText)
            .modifier(PlaceholderStyle(showPlaceHolder: addCollectionViewModel.collectionNameText.isEmpty,
                                   placeholder: "Name of Collection"))
            .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(.white)))
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
    
    var addButton: some View {
        Text("Add Collection")
            .modifier(ButtonViewCustomRoundedStyle(buttonColor: Color(red: 255/255, green: 187/255, blue: 59/255)))
            .onTapGesture {
                isPresented = false
                addCollectionViewModel.addToDatabase()
            }
    }
    
    var closeButton: some View{
        Image(systemName: "xmark.circle")
            .resizable()
            .scaledToFit()
            .foregroundColor(.blue)
            .frame(width: 30, height: 30)
            .onTapGesture {
                isPresented = false
            }
    }
}

struct AddCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        AddCollectionView(isPresented: .constant(true))
    }
}
