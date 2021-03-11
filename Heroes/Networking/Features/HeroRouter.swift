//
//  HeroRouter.swift
//  Heroes
//
//  Created by Jaime Escobar on 08/03/21.
//

import Foundation
import Alamofire

enum HeroRouter: URLRequestConvertible {
    case getHero(id: Int)
    
    var method: HTTPMethod {
        switch self {
            case .getHero(_):
                return .get
        }
    }
    
    var path: String {
        switch self {
            case .getHero(let id):
                return "/\(id)"
        }
    }
    
    var parameters: Parameters {
        switch self {
            case .getHero(_):
                return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try API.baseUrl.appending(API.apiKey).asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path),
            method: method)
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        debugPrint(urlRequest.url?.absoluteString ?? "no valid url")
        return urlRequest
    }
}
