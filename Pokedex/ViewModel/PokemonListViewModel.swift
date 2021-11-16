//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation

class PokemonListViewModel/*: ObservableObject*/ {
    
//    @Published var pokemons: [Pokemon] = []
    var pokemons: [Pokemon] = []

    var title: String { "Pokedex" }
    var isLoading: Bool = false
    
    var fetched = false
    
    func requestData() {
        if !fetched {
            fetchDataFromLocalDB()
            fetched = true
        }
        guard !isLoading else { return }
        isLoading = true
//        PokemonAPI.requestPokemon { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case let .success(pokemons):
//                let count = try? Database.shared.fetchCount()
//                var filteredPokemons = pokemons.filter { pokemon in
//                    pokemon.id > (count ?? 0)
//                }
//                try? Database.shared.savePokemons(&filteredPokemons)
//                self.pokemons += filteredPokemons
//                self.isLoading = false
//            case let .failure(error):
//                print(error)
//                self.isLoading = false
//                break
//            }
//        }
    }
    
    func fetchDataFromLocalDB() {
        guard !fetched else { return }
        if let pokemons = try? Database.shared.fetchPokemons() {
//            self.pokemons += pokemons
            fetched = true
        }
    }
}
