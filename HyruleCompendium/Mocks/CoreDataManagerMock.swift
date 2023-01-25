//
//  CoreDataManagerMock.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 25/01/23.
//

import Foundation

class CoreDataManagerMock: CoreDataProtocol {
    func setAllData(data: All) throws { }
    
    func removeAll() throws { }
    
    func getMonsters() throws -> [CoreDataMonster] {
        [ CoreDataMonster() ]
    }
    
    func getMaterials() throws -> [CoreDataMaterial] {
        [ CoreDataMaterial() ]
    }
    
    func getEquipments() throws -> [CoreDataEquipment] {
        [ CoreDataEquipment() ]
    }   
}

