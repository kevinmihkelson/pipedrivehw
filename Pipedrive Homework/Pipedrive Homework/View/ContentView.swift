//
//  ContentView.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Text("Select an item")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
