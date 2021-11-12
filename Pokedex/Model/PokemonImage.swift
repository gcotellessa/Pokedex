//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation

struct PokemonImage: Codable {
    let frontDefault: String?
    let frontShiny: String?
    let backDefault: String?
    let backShiny: String?
    
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case backDefault = "back_default"
        case backShiny = "back_shiny"
    }
    
    func getAllImagesURL() -> [String] {
        var images = [String]()
        
        if let front = frontDefault {
            images.append(front)
        }
        if let frontShiny = frontShiny {
            images.append(frontShiny)
        }
        if let back = backDefault {
            images.append(back)
        }
        if let backShiny = backShiny {
            images.append(backShiny)
        }
        return images
    }
}
