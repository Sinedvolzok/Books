//
//  NewGenreView.swift
//  Books
//
//  Created by Denis Kozlov on 25.10.2024.
//

import SwiftUI

struct NewGenreView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var color = Color.red
 
    var body: some View {
        NavigationStack {
            Form {
                TextField("name", text: $name)
                ColorPicker("Set the genre color",
                            selection: $color,
                            supportsOpacity: false)
                Button("Create") {
                    let newGenre = Genre(name: name,
                                         color: color.toHexString()!)
                    context.insert(newGenre)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .disabled(name.isEmpty)
            }
            .padding()
            .navigationTitle("New Genre")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewGenreView()
}
