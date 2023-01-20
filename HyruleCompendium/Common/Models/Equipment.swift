//
//  Equipment.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 24/01/23.
//

import Foundation

struct Equipment: Codable, Hashable, Identifiable {
    
    let id: Int
    var category: String
    var commonLocations: [String]?
    var description: String
    var image: String
    var name: String
    let defense: Int?
    let attack: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, category, description, image, name, commonLocations = "common_locations", defense, attack
    }
}

extension Equipment: ListItemPresentable {
    var topLeftSymbol: String { "figure.fencing" }
    var topLeftValue: String { "\(attack ?? 0)" }
    var topRightSymbol: String { "shield.fill" }
    var topRightValue: String { "\(defense ?? 0)" }
    var listItemUIValues: ListItemUIConfiguration {
        ListItemUIConfiguration(
            cellImageSize: 100,
            cornerRadius: 10,
            spacing: 4
        )
    }
}

extension Equipment: DetailPresentable {
    
    var detailUIValues: DetailUIConfiguration {
        DetailUIConfiguration(
            mainImageSize: 250,
            cornerRadius: 10,
            spacing: 4
        )
    }
    
    var horizontalItemsList: [DetailHorizontalItemsList] {
        [
            DetailHorizontalItemsList(title: Localizables.commonPlacesTitle, items: commonLocations ?? [])
        ]
    }
}
