//
//  BooksApp.swift
//  Books
//
//  Created by Denis Kozlov on 20.04.2024.
//

import SwiftUI
import SwiftData

@main
struct BooksApp: App {
    var body: some Scene {
        WindowGroup {
            BooksListView()
        }
        .modelContainer(for: Book.self)
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
