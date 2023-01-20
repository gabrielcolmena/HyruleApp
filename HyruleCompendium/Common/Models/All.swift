//
//  All.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 24/01/23.
//

import Foundation

struct All: Codable, Hashable {
    let monsters: [Monster]
    let equipments: [Equipment]
    let materials: [Material]
    
    enum CodingKeys: String, CodingKey {
        case monsters, equipments = "equipment", materials
    }
}
