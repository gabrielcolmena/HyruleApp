//
//  CoreDataManager.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 21/01/23.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    private let container: NSPersistentContainer!
    
    init() {
        container = NSPersistentContainer(name: "HyruleCompendium")
        setupDatabase()
    }
    
    private func setupDatabase() {
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("Error loading store \(desc) — \(error)")
                return
            }
        }
    }
    
    //MARK: - Monster
    func setMonsters(with monsters: [Monster]) throws {
        let context = container.viewContext
        do {
            try removeEntity(with: context, and: "CoreDataMonster")
            try context.save()
            
            for monster in monsters {
                let newMonster = NSEntityDescription.insertNewObject(forEntityName: "CoreDataMonster", into: context)
                newMonster.setValue(monster.id, forKey: Monster.CodingKeys.id.rawValue)
                newMonster.setValue(monster.category, forKey: Monster.CodingKeys.category.rawValue)
                newMonster.setValue(monster.commonLocations, forKey: Monster.CodingKeys.commonLocations.rawValue)
                newMonster.setValue(monster.description, forKey: "explanation")
                newMonster.setValue(monster.drops, forKey: Monster.CodingKeys.drops.rawValue)
                newMonster.setValue(monster.image, forKey: Monster.CodingKeys.image.rawValue)
                newMonster.setValue(monster.name, forKey: Monster.CodingKeys.name.rawValue)
            }
            do {
                try context.save()
            } catch {
                throw DataError.invalidDataModel
            }
            
        } catch {
            throw DataError.invalidDataModel
        }
    }
    
    func getMonsters() throws -> [CoreDataMonster] {
        let fetchRequest: NSFetchRequest<CoreDataMonster> = CoreDataMonster.fetchRequest()
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            throw DataError.invalidDataModel
        }
    }
    
    //MARK: - Equipment
    func setEquipment(with equipments: [Equipment]) throws {
        let context = container.viewContext
        do {
            try removeEntity(with: context, and: "CoreDataEquipment")
            try context.save()
            
            for equipment in equipments {
                let newEquipment = NSEntityDescription.insertNewObject(forEntityName: "CoreDataEquipment", into: context)
                newEquipment.setValue(equipment.id, forKey: Equipment.CodingKeys.id.rawValue)
                newEquipment.setValue(equipment.category, forKey: Equipment.CodingKeys.category.rawValue)
                newEquipment.setValue(equipment.commonLocations, forKey: Equipment.CodingKeys.commonLocations.rawValue)
                newEquipment.setValue(equipment.description, forKey: "explanation")
                newEquipment.setValue(equipment.image, forKey: Equipment.CodingKeys.image.rawValue)
                newEquipment.setValue(equipment.name, forKey: Equipment.CodingKeys.name.rawValue)
                newEquipment.setValue(equipment.defense, forKey: Equipment.CodingKeys.defense.rawValue)
                newEquipment.setValue(equipment.attack, forKey: Equipment.CodingKeys.attack.rawValue)
            }
            do {
                try context.save()
            } catch {
                throw DataError.invalidDataModel
            }
            
        } catch {
            throw DataError.invalidDataModel
        }
    }
    
    func getEquipments() throws -> [CoreDataEquipment] {
        let fetchRequest: NSFetchRequest<CoreDataEquipment> = CoreDataEquipment.fetchRequest()
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            throw DataError.invalidDataModel
        }
    }
    
    //MARK: - Materials
    func setMaterials(with materials: [Material]) throws {
        let context = container.viewContext
        do {
            try removeEntity(with: context, and: "CoreDataMaterial")
            try context.save()
            
            for material in materials {
                let newMaterial = NSEntityDescription.insertNewObject(forEntityName: "CoreDataMaterial", into: context)
                newMaterial.setValue(material.id, forKey: Material.CodingKeys.id.rawValue)
                newMaterial.setValue(material.category, forKey: Material.CodingKeys.category.rawValue)
                newMaterial.setValue(material.commonLocations, forKey: Material.CodingKeys.commonLocations.rawValue)
                newMaterial.setValue(material.cookinEffect, forKey: Material.CodingKeys.cookinEffect.rawValue)
                newMaterial.setValue(material.description, forKey: "explanation")
                newMaterial.setValue(material.heartsRecovered, forKey: Material.CodingKeys.heartsRecovered.rawValue)
                newMaterial.setValue(material.image, forKey: Material.CodingKeys.image.rawValue)
                newMaterial.setValue(material.name, forKey: Material.CodingKeys.name.rawValue)
            }
            do {
                try context.save()
            } catch {
                throw DataError.invalidDataModel
            }
            
        } catch {
            throw DataError.invalidDataModel
        }
    }
    
    func getMaterials() throws -> [CoreDataMaterial] {
        let fetchRequest: NSFetchRequest<CoreDataMaterial> = CoreDataMaterial.fetchRequest()
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            throw DataError.invalidDataModel
        }
    }
    
    //MARK: - All / General
    func setAllData(data: All) throws {
        try setMonsters(with: data.monsters)
        try setEquipment(with: data.equipments)
        try setMaterials(with: data.materials)
    }
    
    func removeAll() throws {
        let context = container.viewContext
        try removeEntity(with: context, and: "CoreDataMonster")
        try removeEntity(with: context, and: "CoreDataEquipment")
        try removeEntity(with: context, and: "CoreDataMaterial")
    }
    
    private func removeEntity(with context: NSManagedObjectContext, and entityName: String) throws {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            throw DataError.removeAllError
        }
    }
}
