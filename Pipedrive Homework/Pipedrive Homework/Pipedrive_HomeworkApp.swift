//
//  Pipedrive_HomeworkApp.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import SwiftUI

@main
struct Pipedrive_HomeworkApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
