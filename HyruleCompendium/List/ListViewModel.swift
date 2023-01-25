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
    
    @Published private(set) var mutableMonsters: [Monster] = []
    var monsters: [Monster] = [] {
        didSet {
            self.mutableMonsters = monsters
        }
    }
    
    @Published private(set) var mutableEquipments: [Equipment] = []
    var equipmments: [Equipment] = [] {
        didSet {
            self.mutableEquipments = equipmments
        }
    }
    
    @Published private(set) var mutableMaterials: [Material] = []
    var materials: [Material] = [] {
        didSet {
            self.mutableMaterials = materials
        }
    }
    
    @Published var toast: Toast? = nil
    @Published private(set) var isLoading = true
    @Published private(set) var hasContent = true
    
    let dataManager: DataProtocol
    init(dataManager: DataProtocol) {
        self.dataManager = dataManager
    }
    
    @MainActor
    func update(on searchText: String) {
        if !searchText.isEmpty {
            self.mutableMonsters = monsters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            self.mutableEquipments = equipmments.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            self.mutableMaterials = materials.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        } else {
            self.mutableMonsters = monsters
            self.mutableEquipments = equipmments
            self.mutableMaterials = materials
        }
        
        self.hasContent = mutableMonsters.count > 0 && mutableEquipments.count > 0 && mutableMaterials.count > 0
    }
    
    @MainActor
    func getAll() async {
        defer { isLoading = false }
        isLoading = true
        
        do {
            let all = try await dataManager.getAll()
            ///Limiting arrays to `itemsLimit` values for simplicity and readability
            let itemsLimit = 5
            self.monsters = all.monsters.count > itemsLimit ? Array(all.monsters[0..<itemsLimit]) : all.monsters
            self.equipmments = all.equipments.count > itemsLimit ? Array(all.equipments[0..<itemsLimit]) : all.equipments
            self.materials = all.materials.count > itemsLimit ? Array(all.materials[0..<itemsLimit]) : all.materials
            
            self.hasContent = all.monsters.count > 0 || all.equipments.count > 0 || all.materials.count > 0
        } catch {
            self.toast = Toast(type: .error, message: error.localizedDescription)
            self.hasContent = false
        }
    }
}
