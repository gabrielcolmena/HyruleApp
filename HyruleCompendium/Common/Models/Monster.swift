//
//  Item.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 19/01/23.
//

import Foundation

struct Monster: Codable, Hashable {
    let id: Int
    var category: String
    var commonLocations: [String]?
    var description: String
    var drops: [String]?
    var image: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id, category, description, image, name, drops, commonLocations = "common_locations"
    }
}

// this approach allows to use different data types to fill the same view
// but allowing certain level of customization such as symbols, corner radius, spacing
// and can be extended as needed
extension Monster: ListItemPresentable {
    var topLeftSymbol: String { "mappin" }
    var topLeftValue: String { "\(commonLocations?.count ?? 0)" }
    var topRightSymbol: String { "archivebox" }
    var topRightValue: String { "\(drops?.count ?? 0)" }
    var listItemUIValues: ListItemUIConfiguration {
        ListItemUIConfiguration(
            cellImageSize: 100,
            cornerRadius: 10,
            spacing: 4
        )
    }
}

extension Monster: DetailPresentable {
    
    var detailUIValues: DetailUIConfiguration {
        DetailUIConfiguration(
            mainImageSize: 180,
            cornerRadius: 10,
            spacing: 4
        )
    }
    var horizontalItemsList: [DetailHorizontalItemsList] {
        [
            DetailHorizontalItemsList(title: Localizables.dropsTitle, items: drops ?? []),
            DetailHorizontalItemsList(title: Localizables.commonPlacesTitle, items: commonLocations ?? [])
        ]
    }
}
