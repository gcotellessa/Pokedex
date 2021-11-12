//
//  PokemonMove.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation

struct PokemonMoveSetting: Codable {
    let move: PokemonMove
}

struct PokemonMove: Codable {
    let name: String
}
