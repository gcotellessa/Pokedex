//
//  PokemonType.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation

struct PokemonTypeSlot: Codable, Hashable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable, Hashable {
    let name: String
}
