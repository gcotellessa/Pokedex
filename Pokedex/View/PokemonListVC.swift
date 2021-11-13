//
//  ViewController.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 09/11/21.
//

import UIKit
import Combine

class PokemonListVC: UIViewController {
    
    var viewModel = PokemonListViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
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
        tableView.register(PokemonListCell.self, forCellReuseIdentifier: PokemonListCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpLayout()
    }
    
    private func bindViewModel() {
        viewModel.$pokemons
           .receive(on: DispatchQueue.main)
           .sink { _ in
               self.tableView.reloadData()
           }.store(in: &cancellables)
    }
    
    private func setUpLayout() {
        
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
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

extension PokemonListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListCell.identifier, for: indexPath) as? PokemonListCell
        cell?.pokemonName = viewModel.pokemons[indexPath.row].name
        cell?.pokemonId = "#\(viewModel.pokemons[indexPath.row].id.description)"
        cell?.pokemonImageUrl = viewModel.pokemons[indexPath.row].sprites.frontDefault
        cell?.setupLayout()
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PokemonDetailVC()
        vc.pokemon = viewModel.pokemons[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isReachingEnd = scrollView.contentOffset.y >= 0
        && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        if isReachingEnd { viewModel.requestData() }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(60))

            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }
    
}



