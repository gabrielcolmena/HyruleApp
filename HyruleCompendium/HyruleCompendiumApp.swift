//
//  HyruleCompendiumApp.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 19/01/23.
//

import SwiftUI

@main
struct HyruleCompendiumApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
