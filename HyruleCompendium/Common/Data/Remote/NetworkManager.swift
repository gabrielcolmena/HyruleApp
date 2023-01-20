//
//  NetworkingManager.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 19/01/23.
//

import Foundation

final class NetworkManager {
    
    func request<T: Codable>(session: URLSession = .shared, _ endpoint: Endpoint, type: T.Type) async throws -> T {
        
        guard let url = endpoint.url else {
            throw DataError.invalidUrl
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw DataError.invalidStatusCode(statusCode: statusCode)
        }
        
        let decoder = JSONDecoder()
        do{
            let res = try decoder.decode(Response<T>.self, from: data)
            return res.data
        } catch {
            debugPrint(error)
            throw DataError.custom(error: error)
        }
        
//        return nil
    }
}

private extension NetworkManager {
    func buildRequest(from url: URL,
                      methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        return request
    }
}
