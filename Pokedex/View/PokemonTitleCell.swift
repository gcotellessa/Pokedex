//
//  PokemonTitleCell.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 11/11/21.
//

import Foundation
import UIKit

class PokemonTitleCell: UITableViewCell {
    
    static let identifier = "PokemonTitleCell"
    
    private lazy var pokemonImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .gray
        view.numberOfLines = 0
        return view
    }()
    
    var pokemonImageUrl: String?
    var pokemonName: String?
    var pokemonDescription = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    override func prepareForReuse() {
        pokemonImageUrl = ""
        pokemonName = ""
        pokemonDescription = ""
    }
    
    func setupLayout() {
        contentView.addSubview(pokemonImageView)
        
        pokemonImageView
            .leading(16, superView: contentView.leadingAnchor)
            .onCenterY()
            .height(120)
            .width(120)
        
        UIImage.load(from: pokemonImageUrl ?? "") { [weak self] image in
            DispatchQueue.main.async { self?.pokemonImageView.image = image }
        }
        
        contentView.addSubview(titleLabel)
        
        titleLabel
            .top(16, superView: contentView.topAnchor)
            .trailing(-16, superView: contentView.trailingAnchor)

        titleLabel.text = pokemonName ?? "missing name"

        contentView.addSubview(descriptionLabel)

        descriptionLabel
            .top(10, superView: titleLabel.bottomAnchor)
            .trailing(-16, superView: contentView.trailingAnchor)
        
        descriptionLabel.text = pokemonDescription
        
        contentView
            .bottom(16, superView: descriptionLabel.bottomAnchor)
    }

}
