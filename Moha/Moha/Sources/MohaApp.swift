//
//  MohaApp.swift
//  Moha
//
//  Created by 변예린 on 8/14/26.
//

import SwiftUI
import SwiftData

@main
struct MohaApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            MohaView()
        }
        .modelContainer(sharedModelContainer)
    }
}
