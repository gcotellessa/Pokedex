//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation

protocol ObservableViewModelProtocol {
    func requestData()
    var pokemons: Observable<[Pokemon]> { get  set }
}

class PokemonListViewModel: ObservableViewModelProtocol {
    
    var pokemons: Observable<[Pokemon]> = Observable([])
    var localPokemons: [Pokemon] = []

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
        PokemonAPI.pokemons { result in
            switch result {
            case .success(let pokemons):
                let count = try? Database.shared.fetchCount()
                var filteredPokemons = pokemons.filter { $0.id > (count ?? 0) }
                filteredPokemons.sort { s1, s2 in  s1.id < s2.id }
                try? Database.shared.savePokemons(&filteredPokemons)
                self.localPokemons += filteredPokemons
                self.pokemons.value = self.localPokemons
                self.isLoading = false
            case .failure(let error):
                print(error.localizedDescription)
                self.isLoading = false
            }
        }
    }
    
    func fetchDataFromLocalDB() {
        guard !fetched else { return }
        if let pokemons = try? Database.shared.fetchPokemons() {
            self.localPokemons += pokemons
            fetched = true
        }
    }
}
