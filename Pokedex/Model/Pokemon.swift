//
//  Pokemon.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 09/11/21.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: PokemonImage
    let types: [PokemonTypeSlot]
    let stats: [PokemonStatSetting]
    let moves: [PokemonMoveSetting]
}
