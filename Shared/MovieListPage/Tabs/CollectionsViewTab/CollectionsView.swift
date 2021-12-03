//
//  CollectionsView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 3.12.2021.
//

import SwiftUI

struct CollectionsView: View {
    @ObservedObject var collectionViewModel = CollectionsViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            ScrollView(showsIndicators: false) {
                LazyVStack{
                    ForEach(collectionViewModel.collections, id: \.id){ collection in
                        Divider()
                        CollectionCellView()
                    }
                }
            }
            
            buttonView
        }
        .sheet(isPresented: $collectionViewModel.isCollectionAddTapped, onDismiss: {
            collectionViewModel.isCollectionAddTappedUpdate(state: false)
        }, content: {
            AddCollectionView(isPresented: $collectionViewModel.isCollectionAddTapped)
        })
    }
    
    var buttonView: some View{
        Button {
            collectionViewModel.addNewCollection()
        } label: {
            Image(systemName: "plus.app")
                .resizable()
                .frame(width: 32, height: 32)
                .padding()
        }
        .background(Color(.systemBlue))
        .foregroundColor(.white)
        .clipShape(Circle())
        .padding()
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
