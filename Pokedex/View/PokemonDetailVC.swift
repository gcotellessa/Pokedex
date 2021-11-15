//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon?
    
    private lazy var safeAreaView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PokemonTitleCell.self, forCellReuseIdentifier: PokemonTitleCell.identifier)
        tableView.register(StatCell.self, forCellReuseIdentifier: StatCell.identifier)
        tableView.register(ImagesCell.self, forCellReuseIdentifier: ImagesCell.identifier)
        tableView.separatorStyle = .singleLine
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpLayout()
    }
    
    private func setUpLayout() {
        
        navigationItem.title = "#\(pokemon?.id.description ?? "") \(pokemon?.name ?? "")"
        view.backgroundColor = .white
        view.addSubview(safeAreaView)
        
        safeAreaView
            .top(0, superView: view.safeAreaLayoutGuide.topAnchor)
            .leading(0, superView: view.safeAreaLayoutGuide.leadingAnchor)
            .trailing(0, superView: view.safeAreaLayoutGuide.trailingAnchor)
            .bottom(0, superView: view.safeAreaLayoutGuide.bottomAnchor)
        
        safeAreaView.addSubview(tableView)
        
        tableView.equalToSuperview()
        
    }

}

extension PokemonDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTitleCell.identifier, for: indexPath) as? PokemonTitleCell else { return UITableViewCell() }
            
            if let pokemon = pokemon {
                cell.pokemonImageUrl = pokemon.sprites.frontDefault
                cell.pokemonName = pokemon.name
                pokemon.types.forEach { type in
                    cell.pokemonDescription += "\(type.type.name)\n"
                }
            }
            
            cell.setupLayout()
            cell.selectionStyle = .none
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImagesCell.identifier, for: indexPath) as? ImagesCell else { return UITableViewCell() }
            
            if let pokemon = pokemon {
                cell.imagesURL.append(pokemon.sprites.backDefault ?? "")
                cell.imagesURL.append(pokemon.sprites.frontShiny ?? "")
                cell.imagesURL.append(pokemon.sprites.backShiny ?? "")
            }
            
            cell.setupLayout()
            cell.selectionStyle = .none
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StatCell.identifier, for: indexPath) as? StatCell else { return UITableViewCell() }
            
            if let pokemon = pokemon {
                cell.statKey = pokemon.stats[indexPath.row - 2].stat.name
                cell.statValue = "\(pokemon.stats[indexPath.row - 2].baseStat) / 100"
            }
            
            cell.setupLayout()
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
}
