//
//  DataManagerMock.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 25/01/23.
//

import Foundation

class DataManagerMock: DataProtocol {
    var coreDataManager: CoreDataProtocol
    var networkManager: NetworkProtocol
    
    init(coreDataManager: CoreDataProtocol, networkManager: NetworkProtocol) {
        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
    }
    
    func getAll() async throws -> All {
        try await networkManager.request(session: .shared, .all, type: All.self)
    }
    
    func removeAll() throws { }
}
