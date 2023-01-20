//
//  Endpoints.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 19/01/23.
//

import Foundation

enum Endpoint {
    case all
}

extension Endpoint {
    enum MethodType: Equatable {
        case GET
        case POST(data: Data?)
    }
}

extension Endpoint {
    
    var host: String { "botw-compendium.herokuapp.com" }
    var api: String { "/api/v2" }
    
    var path: String {
        switch self {
        case .all:
            return "/all"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .all:
            return .GET
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = "\(api)" + "\(path)"
        
        return urlComponents.url
    }
}
