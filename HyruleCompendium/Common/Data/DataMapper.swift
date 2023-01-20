//
//  DataMapper.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 22/01/23.
//

import Foundation

final class DataMapper {
    static func fromCoreDataMonsterToMonster(coreMonster: CoreDataMonster) -> Monster {
        let id = Int(coreMonster.id)
        let category = coreMonster.category ?? ""
        let commonLocations = coreMonster.common_locations as? [String] ?? []
        let description = coreMonster.explanation ?? ""
        let drops = coreMonster.drops as? [String] ?? []
        let image = coreMonster.image ?? ""
        let name = coreMonster.name ?? ""
        
        return Monster (
            id: id,
            category: category,
            commonLocations: commonLocations,
            description: description,
            drops: drops,
            image: image,
            name: name
        )
    }
    
    static func fromCoreDataEquipmentToEquipment(coreEquipment: CoreDataEquipment) -> Equipment {
        let id = Int(coreEquipment.id)
        let category = coreEquipment.category ?? ""
        let commonLocations = coreEquipment.common_locations as? [String] ?? []
        let description = coreEquipment.explanation ?? ""
        let image = coreEquipment.image ?? ""
        let name = coreEquipment.name ?? ""
        let defense = Int(coreEquipment.defense)
        let attack = Int(coreEquipment.attack)
        
        return Equipment (
            id: id,
            category: category,
            commonLocations: commonLocations,
            description: description,
            image: image,
            name: name,
            defense: defense,
            attack: attack
        )
    }
    
    static func fromCoreDataMaterialToMaterial(coreMaterial: CoreDataMaterial) -> Material {
        
        let id = Int(coreMaterial.id)
        let category = coreMaterial.category ?? ""
        let commonLocations = coreMaterial.common_locations as? [String] ?? []
        let cookinEffect = coreMaterial.cooking_effect ?? ""
        let description = coreMaterial.explanation ?? ""
        let heartsRecovered = CGFloat(coreMaterial.hearts_recovered)
        let image = coreMaterial.image ?? ""
        let name = coreMaterial.name ?? ""
        
        return Material(
            id: id,
            category: category,
            commonLocations: commonLocations,
            cookinEffect:  cookinEffect,
            description: description,
            heartsRecovered: heartsRecovered,
            image: image,
            name: name
        )
    }
}
