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
            HStack{
                Spacer()
                closeButton
                    .padding()
            }
            Spacer()

            ZStack{
                Circle()
                    .foregroundColor(.white)
                    .overlay(Circle().stroke(.black ,lineWidth: 3))
                    .frame(width: 150, height: 150)
                
                Image(systemName: "folder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }
            
            collectionName
                .padding(.top,40)
            
            addButton
                .padding(.top)
            Spacer()
        }
    }
    
    var collectionName: some View {
        TextField("Name of Collection", text: $addCollectionViewModel.collectionNameText)
            .modifier(TextFieldCustomRoundedStyle(fieldColor: Color(.black)))
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
    
    var addButton: some View {
        Text("Add Collection")
            .modifier(ButtonViewCustomRoundedStyle(buttonColor: Color(.blue)))
            .onTapGesture {
                isPresented = false
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
