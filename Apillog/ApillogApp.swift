//
//  ApillogApp.swift
//  Apillog
//
//  Created by yeni on 9/25/24.
//

import SwiftUI
import SwiftData

@main
struct ApillogApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PrimaryMedication.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            TodayView()
        }
        .modelContainer(sharedModelContainer)
    }
}
