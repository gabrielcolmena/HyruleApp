//
//  Materials.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 24/01/23.
//

import Foundation

struct Material: Codable, Hashable {
    let id: Int
    var category: String
    var commonLocations: [String]?
    var cookinEffect: String
    var description: String
    var heartsRecovered: CGFloat
    var image: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case heartsRecovered = "hearts_recovered", cookinEffect = "cooking_effect", commonLocations = "common_locations", category, description, id, image, name
    }
}

extension Material: ListItemPresentable {
    var topLeftSymbol: String { "mappin" }
    var topLeftValue: String { "\(commonLocations?.count ?? 0)" }
    var topRightSymbol: String { "heart" }
    var topRightValue: String { "+\(heartsRecovered)" }
    var listItemUIValues: ListItemUIConfiguration {
        ListItemUIConfiguration(
            cellImageSize: 100,
            cornerRadius: 10,
            spacing: 4
        )
    }
}

extension Material: DetailPresentable {
    
    var detailUIValues: DetailUIConfiguration {
        DetailUIConfiguration(
            mainImageSize: 180,
            cornerRadius: 10,
            spacing: 4
        )
    }
    var horizontalItemsList: [DetailHorizontalItemsList] {
        [
            DetailHorizontalItemsList(title: Localizables.commonPlacesTitle, items: commonLocations ?? []),
            DetailHorizontalItemsList(title: Localizables.cookignEffectTitle, items: [cookinEffect])
        ]
    }
}
