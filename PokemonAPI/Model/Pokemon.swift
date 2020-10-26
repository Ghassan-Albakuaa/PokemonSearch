//
//  Pokemon.swift
//  PokemonAPI
//
//  Created by Ghassan  albakuaa  on 10/25/20.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let id: Int
    let sprites: Sprite
    
}

struct Sprite: Decodable {
    let frontDefault: URL
}
