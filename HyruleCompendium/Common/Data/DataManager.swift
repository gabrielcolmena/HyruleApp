//
//  DataManage4r.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 22/01/23.
//

import Foundation

protocol DataProtocol {
    var coreDataManager: CoreDataProtocol {get set}
    var networkManager: NetworkProtocol {get set}
    
    func getAll() async throws -> All
    func removeAll() throws
}

final class DataManager: DataProtocol {
    
    internal var coreDataManager: CoreDataProtocol
    internal var networkManager: NetworkProtocol
    
    init(coreDataManager: CoreDataProtocol, networkManager: NetworkProtocol) {
        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
    }
    
    func getAll() async throws -> All {
        do {
            let coreMonsters = try coreDataManager.getMonsters()
            let coreEquipments = try coreDataManager.getEquipments()
            let coreMaterials = try coreDataManager.getMaterials()
            
            if coreMonsters.count > 0 || coreEquipments.count > 0 {
                print ("persisted all")
                let monsters = coreMonsters.compactMap { coreMonster in
                    DataMapper.fromCoreDataMonsterToMonster(coreMonster: coreMonster)
                }
                
                let equipments = coreEquipments.compactMap { coreEquipment in
                    DataMapper.fromCoreDataEquipmentToEquipment(coreEquipment: coreEquipment)
                }
                
                let materials = coreMaterials.compactMap { coreMaterial in
                    DataMapper.fromCoreDataMaterialToMaterial(coreMaterial: coreMaterial)
                }
                return All(
                    monsters: monsters,
                    equipments: equipments,
                    materials: materials
                )
            } else {
                print ("no persisted all")
                do {
                    let all = try await networkManager.request(
                        session: .shared,
                        .all,
                        type: All.self
                    )
                    
                    try coreDataManager.setAllData(data: all)
                    print ("returning endpoint all")
                    return all
                } catch {
                    throw error
                }
            }
        }
    }
    
    func removeAll() throws {
        do {
            try coreDataManager.removeAll()
        } catch {
            throw error
        }
    }
}

enum DataError: LocalizedError {
    case invalidUrl
    case custom(error: Error)
    case invalidStatusCode(statusCode: Int)
    case invalidData
    case failedToDecode(error: Error)
    case invalidContainerName
    case invalidDataModel
    case removeAllError
}

extension DataError {
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl: return Localizables.invalidUrl;
        case .invalidStatusCode: return Localizables.invalidStatusCode;
        case .invalidData: return Localizables.invalidData;
        case .failedToDecode: return Localizables.failedToDecode;
        case .invalidContainerName: return Localizables.invalidContainerName;
        case .invalidDataModel: return Localizables.invalidDataModel;
        case .removeAllError: return Localizables.removeAllError;
        case .custom(let err):
            return "Something went wrong \(err.localizedDescription)"
        }
    }
}
