//
//  PokemonStat.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation

struct PokemonStatSetting: Codable, Hashable {
    let baseStat: Int
    let effort: Int
    let stat: PokemonStat
    
    private enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

struct PokemonStat: Codable, Hashable {
    let name: String
}
