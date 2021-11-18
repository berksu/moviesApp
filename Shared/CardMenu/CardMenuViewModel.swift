//
//  cardViewModel.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 17.11.2021.
//

import Foundation

final class CardMenuViewModel: ObservableObject{
    @Published var categories: [CardMenuCategories] = [CardMenuCategories(categoryName: "drama"),
                                                       CardMenuCategories(categoryName: "action"),
                                                       CardMenuCategories(categoryName: "love"),
                                                       CardMenuCategories(categoryName: "drama2"),
                                                       CardMenuCategories(categoryName: "action2"),
                                                       CardMenuCategories(categoryName: "love2"),
                                                       CardMenuCategories(categoryName: "drama3"),
                                                       CardMenuCategories(categoryName: "action3"),
                                                       CardMenuCategories(categoryName: "love3")]
    
    //@Published var cardViews:[CardView] = [CardView(offset_x: 40, opacity_v: 0.2, scaleRate: 0.9),
    //                                       CardView(offset_x: 20, opacity_v: 0.4, scaleRate: 0.95),
    //                                       CardView(offset_x: 0, opacity_v: 1, scaleRate: 1)]
}
