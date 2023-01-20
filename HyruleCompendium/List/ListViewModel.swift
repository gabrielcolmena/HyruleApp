//
//  ListViewModel.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 19/01/23.
//

import Foundation

protocol ListViewModelPresentable {
    var title: String { get }
    var monstersTitle: String { get }
    var equipmentTitle: String { get }
    var materialsTitle: String { get }
    var topRightSymbol: String { get }
}

final class ListViewModel: ObservableObject, ListViewModelPresentable {
    
    var title: String { Localizables.appName }
    var monstersTitle: String { Localizables.monstersTitle }
    var equipmentTitle: String { Localizables.equipmentTitle }
    var materialsTitle: String { Localizables.materialTitle }
    var topRightSymbol: String { "gear" }
    
    @Published private(set) var monsters: [Monster] = []
    var originalMonsters: [Monster] = [] {
        didSet {
            self.monsters = originalMonsters
        }
    }
    
    @Published private(set) var equipments: [Equipment] = []
    var originalEquipmments: [Equipment] = [] {
        didSet {
            self.equipments = originalEquipmments
        }
    }
    
    @Published private(set) var materials: [Material] = []
    var originalMaterials: [Material] = [] {
        didSet {
            self.materials = originalMaterials
        }
    }
    
    @Published var toast: Toast? = nil
    @Published private(set) var isLoading = true
    @Published private(set) var hasContent = true
    
    let dataManager: DataManager
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    @MainActor
    func update(on searchText: String) {
        if !searchText.isEmpty {
            self.monsters = originalMonsters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            self.equipments = originalEquipmments.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            self.materials = originalMaterials.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        } else {
            self.monsters = originalMonsters
            self.equipments = originalEquipmments
            self.materials = originalMaterials
        }
    }
    
    @MainActor
    func getAll() async {
        defer { isLoading = false }
        isLoading = true
        
        do {
            let all = try await dataManager.getAll()
            ///Limiting arrays to `itemsLimit` values for simplicity and readability
            let itemsLimit = 5
            self.originalMonsters = all.monsters.count > itemsLimit ? Array(all.monsters[0..<itemsLimit]) : all.monsters
            self.originalEquipmments = all.equipments.count > itemsLimit ? Array(all.equipments[0..<itemsLimit]) : all.equipments
            self.materials = all.materials.count > itemsLimit ? Array(all.materials[0..<itemsLimit]) : all.materials
            
            self.hasContent = all.monsters.count > 0 || all.equipments.count > 0 || all.materials.count > 0
        } catch {
            self.toast = Toast(type: .error, message: error.localizedDescription)
            self.hasContent = false
        }
    }
}
