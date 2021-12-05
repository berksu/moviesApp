//
//  CollectionsView.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 3.12.2021.
//

import SwiftUI
import SwipeCellSUI

struct CollectionsView: View {
    @ObservedObject var collectionViewModel = CollectionsViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            ScrollView(showsIndicators: false) {
                LazyVStack{
                    ForEach(collectionViewModel.collections, id: \.id){ collection in
                        Divider()
                        NavigationLink {
                            CollectionDetailsListView(title: collection.title ?? "",
                                                  movieIDs: collection.movieIDs ?? [])
                        } label: {
                            CollectionCellView(collectionName: collection.title ?? "Failed")
                                .swipeCell(leadingSideGroup: rightGroup(id: collection.id), trailingSideGroup: rightGroup(id: collection.id), currentUserInteractionCellID: .constant(collection.id))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            
            buttonView
        }
        .sheet(isPresented: $collectionViewModel.isCollectionAddTapped, onDismiss: {
            collectionViewModel.isCollectionAddTappedUpdate(state: false)
            collectionViewModel.fetchCollectionsFromDatabase()
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
    
    
    func rightGroup(id: String)->[SwipeCellActionItem] {

        let items =  [
            SwipeCellActionItem(buttonView: {
                self.trashView(swipeOut: false)
            }, swipeOutButtonView: {
                self.trashView(swipeOut: true)
            }, backgroundColor: .red, swipeOutAction: true, swipeOutHapticFeedbackType: .warning, swipeOutIsDestructive: true) {
                collectionViewModel.deleteCollectionCell(id: id)
            }
          ]
        
        return items
    }
    
    func trashView(swipeOut: Bool)->AnyView {
            VStack(spacing: 3)  {
                Image(systemName: "trash").font(.system(size: swipeOut ? 28 : 22)).foregroundColor(.white)
                Text("Delete").fixedSize().font(.system(size: swipeOut ? 16 : 12)).foregroundColor(.white)
            }.frame(maxHeight: 80).animation(.default,value: UUID()).castToAnyView()
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
