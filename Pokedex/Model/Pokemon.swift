//
//  Pokemon.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 09/11/21.
//

import Foundation
import GRDB

struct Pokemon: Codable, Identifiable, Hashable {
    var id: Int
    let name: String
    let height: Int
    let weight: Int
    var sprites: PokemonImage
    let types: [PokemonTypeSlot]
    let stats: [PokemonStatSetting]
    let moves: [PokemonMoveSetting]
}

extension Pokemon: FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    fileprivate enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let height = Column(CodingKeys.height)
        static let weight = Column(CodingKeys.weight)
        static let sprites = Column(CodingKeys.sprites)
        static let types = Column(CodingKeys.types)
        static let stats = Column(CodingKeys.stats)
        static let moves = Column(CodingKeys.moves)
    }
    
}
