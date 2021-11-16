//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation
import Combine
import SwiftUI

class API {
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    enum ItemType: String {
        case pokemons = "pokemon"
    }
}

final class PokemonAPI: API {
    
    private static var pokemonResponse: APIResponse?
    
    static func apiResponse(urlString: String?, _ completion: @escaping (Result<APIResponse, Error>) -> ()) {
        
        let finalURL: URL

        if let urlString = urlString, let url = URL(string: urlString) {
            finalURL = url
        } else {
            finalURL = baseURL.appendingPathComponent(PokemonAPI.ItemType.pokemons.rawValue)
        }
        
        let task = URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            } else if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    pokemonResponse = decodedResponse
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    static func pokemons(_ completion: @escaping (Result<[Pokemon], Error>) -> ()) {
        
        apiResponse(urlString: pokemonResponse?.next) { result in
            
            switch result {
            case .success(let apiResponse):
                let group = DispatchGroup()
                
                var pokemons: [Pokemon] = []
                
                apiResponse.results.forEach { apiItem in
                    group.enter()
                    
                    pokemon(urlString: apiItem.url) { result in
                        group.leave()
                        switch result {
                        case .success(let pokemon):
                            pokemons.append(pokemon)
                        case .failure(_):
                            break
                        }
                    }
                }
                
                group.notify(queue: .main, execute: {
                    completion(.success(pokemons))
                })
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func pokemon(urlString: String, _ completion: @escaping (Result<Pokemon, Error>) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            } else if let data = data {
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(.success(pokemon))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
}



