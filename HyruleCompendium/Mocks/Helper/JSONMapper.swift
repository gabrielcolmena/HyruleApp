//
//  JSONMapper.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 25/01/23.
//

import Foundation

struct LocalJSONMapper {
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        
        guard !file.isEmpty,
              let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContents
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

extension LocalJSONMapper {
    enum MappingError: Error {
        case failedToGetContents
    }
}
