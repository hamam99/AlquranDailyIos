//
//  AlquranReminderApp.swift
//  AlquranReminder
//
//  Created by Hamam Nasrodin on 30/08/2026.
//

import SwiftData
import SwiftUI

@main
struct AlquranReminderApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema: Schema = Schema([])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
