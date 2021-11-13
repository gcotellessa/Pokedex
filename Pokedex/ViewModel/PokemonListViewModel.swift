//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation

class PokemonListViewModel: ObservableObject {
    
    @Published var pokemons: [Pokemon] = []

    var title: String { "Pokedex" }
    var isLoading: Bool = false
    
    func requestData() {
        guard !isLoading else { return }
        isLoading = true
        PokemonAPI.requestPokemon { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(pokemons):
                self.pokemons += pokemons
                self.isLoading = false
            case let .failure(error):
                print(error)
                break
            }
        }
    }
}
