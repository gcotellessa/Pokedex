//
//  Service.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import UIKit
import Combine

class API {
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    static var cancellables = Set<AnyCancellable>()
    
    enum ItemType: String {
        case pokemons = "pokemon"
        case items = "item"
    }
}

struct NetworkAgent {
    static func execute<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
