//
//  Genre.swift
//  Books
//
//  Created by Denis Kozlov on 18.10.2024.
//

import SwiftUI
import SwiftData

@Model
class Genre {
    
    var name: String
    var color: String
    var books: [Book]?
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    var hexColor: Color {
        .init(hex: self.color) ?? .red
    }
}
