//
//  Hero.swift
//  Heroes
//
//  Created by Jaime Escobar on 08/03/21.
//

import Foundation

struct Hero: Decodable {
    let id: String
    let name: String
    let powerstats: PowerStats
    let biography: Bio
    let appearance: Appearance
    let work: Work
    let image: Image
}

struct PowerStats: Decodable {
    let intelligence: String
    let strength: String
    let speed: String
    let durability: String
    let power: String
    let combat: String
}

struct Bio: Decodable {
    let fullName: String
    let alterEgos: String
    let aliases: [String]
    let placeOfBirth: String
    let firstAppearance: String
    let publisher: String
    let alignment: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full-name"
        case alterEgos = "alter-egos"
        case aliases
        case placeOfBirth = "place-of-birth"
        case firstAppearance = "first-appearance"
        case publisher
        case alignment
    }
}

struct Appearance: Decodable {
    let gender: String
    let race: String
    let height: [String]
    let weight: [String]
    let eyeColor: String
    let hairColor: String
    
    enum CodingKeys: String, CodingKey {
        case gender
        case race
        case height
        case weight
        case eyeColor = "eye-color"
        case hairColor = "hair-color"
    }
}

struct Work: Decodable {
    let occupation: String
    let base: String
}

struct Image: Decodable {
    let url: String
}
