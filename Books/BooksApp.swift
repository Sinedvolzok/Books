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
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            BooksListView()
        }
        .modelContainer(container)
    }
    
    init() {
        let schema = Schema([Book.self])
        let configuration = ModelConfiguration("Books", schema: schema)
        do {
            container = try ModelContainer(
                for: schema,
                configurations: configuration
            )
        } catch {
            fatalError("Could not create model container: \(error)")
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
