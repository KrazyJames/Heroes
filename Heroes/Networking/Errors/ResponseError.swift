//
//  ResponseError.swift
//  Heroes
//
//  Created by Jaime Escobar on 08/03/21.
//

import Foundation

struct ResponseError: Decodable {
    let response: String
    let error: String
}
