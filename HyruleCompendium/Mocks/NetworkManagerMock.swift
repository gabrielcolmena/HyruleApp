//
//  NetworkManagerMock.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 25/01/23.
//

import Foundation

class NetworkManagerMock: NetworkProtocol {
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return (try LocalJSONMapper.decode(file: "All", type: ServerResponse<T>.self)).data
    }
}
