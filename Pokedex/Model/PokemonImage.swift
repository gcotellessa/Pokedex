//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation

struct PokemonImage: Codable, Hashable {
    var frontDefault: String?
    var frontShiny: String?
    var backDefault: String?
    var backShiny: String?
    
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case backDefault = "back_default"
        case backShiny = "back_shiny"
    }

}
