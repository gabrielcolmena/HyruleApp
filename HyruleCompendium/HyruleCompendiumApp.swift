//
//  HyruleCompendiumApp.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 19/01/23.
//

import SwiftUI

@main
struct HyruleCompendiumApp: App {
    
    let dataManager = DataManager(coreDataManager: CoreDataManager(), networkManager: NetworkManager())
    
    var body: some Scene {
        WindowGroup {
            ListView(dataManager: dataManager)
        }
    }
}
