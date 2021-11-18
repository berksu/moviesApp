//
//  Card.swift
//  movie (iOS)
//
//  Created by Berksu Kısmet on 18.11.2021.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String

    var isDraggable: Bool
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker", isDraggable: true)
    }
    static var example1: Card {
        Card(prompt: "1", answer: "1", isDraggable: true)
    }
    static var example2: Card {
        Card(prompt: "2", answer: "2", isDraggable: true)
    }
    static var example3: Card {
        Card(prompt: "3", answer: "3", isDraggable: true)
    }
    static var example4: Card {
        Card(prompt: "4", answer: "4", isDraggable: true)
    }
    static var example5: Card {
        Card(prompt: "5", answer: "4", isDraggable: true)
    }
    static var example_nonDraggable: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who? drag", answer: "Jodie Whittaker", isDraggable: false)
    }
    
    
}
