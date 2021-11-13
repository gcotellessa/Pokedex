//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation
import Combine

class API {
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    static var cancellables = Set<AnyCancellable>()
    
    enum ItemType: String {
        case pokemons = "pokemon"
    }
}

final class PokemonAPI: API {
    
    private static var pokemonResponse: APIResponse?
    
    static func requestPokemon(_ completion: @escaping (Result<[Pokemon], Error>) -> Swift.Void) {
        requestPokemon(at: pokemonResponse?.next)?.flatMap { response in
            Publishers.Sequence(sequence: response.results.compactMap { pokemonDetails(from: $0.url) })
                .flatMap { $0 }
                .collect()
        }
        .eraseToAnyPublisher()
        .sink { result in
            completion(result.map { res in res.sorted { $0.id < $1.id } })
        }.store(in: &cancellables)
    }
}

extension PokemonAPI {
    
    private static func pokemonDetails(from urlString: String) -> AnyPublisher<Pokemon, Error>? {
        guard let url = URL(string: urlString) else { return nil }
        let request = URLRequest(url: url)
        return NetworkAgent.execute(request)
    }
    
    private static func requestPokemon(at urlString: String?) -> AnyPublisher<APIResponse, Error>? {
        let finalURL: URL
        
        if let urlString = urlString, let url = URL(string: urlString) {
            finalURL = url
        } else {
            finalURL = baseURL.appendingPathComponent(PokemonAPI.ItemType.pokemons.rawValue)
        }
        
        let request = URLRequest(url: finalURL)
        
        return NetworkAgent.execute(request).map { (response: APIResponse) -> APIResponse in
            self.pokemonResponse = response
            return response
        }.eraseToAnyPublisher()
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

