//
//  MockGenre.swift
//  Books
//
//  Created by Denis Kozlov on 23.10.2024.
//

import Foundation

extension Genre {
    static var mock: [Genre] {
        
        // array of 8 excemplars of class Genre with name as string and color in string HEX format
        [
            Genre(name: "Fiction", color: "#000000"),
            Genre(name: "Fantasy", color: "#FF0000"),
            Genre(name: "Horror", color: "#00FF00"),
            Genre(name: "Romance", color: "#0000FF"),
            Genre(name: "Science Fiction", color: "#FFFF00"),
            Genre(name: "Thriller", color: "#00FFFF"),
            Genre(name: "Young Adult", color: "#FF00FF"),
            Genre(name: "Non Fiction", color: "#0F0F00"),
            Genre(name: "Mystery", color: "#F0000F"),
        ]
        
    }
}
