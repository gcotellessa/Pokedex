//
//  ApiResponse.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation

struct APIResponse: Decodable {
    let next: String
    let results: [APIItem]
}

struct APIItem: Decodable {
    let name: String
    let url: String
}
