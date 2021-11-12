//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation

class PokemonListViewModel: ObservableObject {
    
    @Published var pokemons: [Pokemon] = []
    
    // MARK: - Public properties
    var title: String { "Pokedex" }
    var isLoading: Bool = false
    
    // MARK: - Public functions
    func requestData() {
        guard !isLoading else { return }
        isLoading = true
        PokemonAPI.requestPokemon { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(pokemon):
                self.isLoading = false
                self.pokemons += pokemon
                self.pokemons.sort { $0.id < $1.id }
            case let .failure(error):
                print(error)
                break
            }
        }
    }
}
