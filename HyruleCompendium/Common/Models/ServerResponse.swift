//
//  Response.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 21/01/23.
//

import Foundation

struct ServerResponse<T: Codable>: Codable {
    var data: T
}
