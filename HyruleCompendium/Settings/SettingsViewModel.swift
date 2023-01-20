//
//  SettingsViewModel.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 23/01/23.
//

import Foundation


final class SettingsViewModel: ObservableObject {
    
    @Published private(set) var error: Error?
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    @MainActor
    func removeAllPersistedData() {
        do {
            try dataManager.removeAll()
        } catch {
            self.error = error
        }
    }
}
