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
    
    var fetched = false
    
    func requestData() {
        if Reachability().isConnectedToNetwork() {
            guard !isLoading else { return }
            isLoading = true
            PokemonAPI.requestPokemon { [weak self] result in
                guard let self = self else { return }
                switch result {
                case var .success(pokemons):
                    try? Database.shared.savePokemons(&pokemons)
                    self.pokemons += pokemons
                    self.isLoading = false
                case let .failure(error):
                    print(error)
                    break
                }
            }
        } else {
            fetchDataFromLocalDB()
        }
    }
    
    func fetchDataFromLocalDB() {
        guard !fetched else { return }
        if let pokemons = try? Database.shared.fetchPokemons() {
            self.pokemons += pokemons
            fetched = true
        }
    }
}
