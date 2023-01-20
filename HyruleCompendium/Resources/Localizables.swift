//
//  Localizables.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 23/01/23.
//

import Foundation

enum Localizables {
    static let appName = "APP_NAME".localized()
    
    // MARK: - Errors
    static let unknownError = "UNKNOWN_ERROR".localized()
    static let info = "INFO".localized()
    static let warning = "WARNING".localized()
    static let success = "SUCCESS".localized()
    static let error = "ERROR".localized()
    static let invalidUrl = "INVALID_URL".localized()
    static let invalidStatusCode = "INVALID_STATUS_CODE".localized()
    static let invalidData = "INVALID_DATA".localized()
    static let failedToDecode = "FILED_TO_DECODE".localized()
    static let invalidContainerName = "INVALID_CONTAINER_NAME".localized()
    static let invalidDataModel = "INVALID_DATA_MODEL".localized()
    static let removeAllError = "REMOVE_ALL_ERROR".localized()
    
    // MARK: - ListView
    static let monstersTitle = "MONSTERS_TITLE".localized()
    static let equipmentTitle = "EQUIPMENT_TITLE".localized()
    static let materialTitle = "MATERIALS_TITLE".localized()
    static let noContentAvailable = "NO_CONTENT_AVAILABLE".localized()
    
    // MARK: - DetailView
    static let dropsTitle = "DROPS_TITLE".localized()
    static let commonPlacesTitle = "COMMON_PLACES_TITLE".localized()
    static let cookignEffectTitle = "COOKING_EFFECT_TITLE".localized()
    
    //MARK: - Settigns
    static let removeAllSuccess = "REMOVE_ALL_SUCCESS".localized()
    static let removeAllData = "REMOVE_ALL_DATA".localized()
    static let dataTitle = "DATA_TITLE".localized()
    
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
