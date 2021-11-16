//
//  PokemonListCell.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation
import UIKit

class PokemonListCell: UITableViewCell {
    
    static let identifier = "PokemonListCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
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
    
    var pokemonName: String?
    var pokemonId: String?
    var pokemonImageUrl: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    override func prepareForReuse() {
        pokemonImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        pokemonName = nil
        pokemonId = nil
        pokemonImageUrl = nil
    }
    
    func setupLayout() {
        contentView.addSubview(containerView)
        
        containerView
            .top(16, superView: contentView.topAnchor)
            .leading(16, superView: contentView.leadingAnchor)
            .trailing(-16, superView: contentView.trailingAnchor)
        
        containerView.addSubview(pokemonImageView)
        
        pokemonImageView
            .leading(16, superView: containerView.leadingAnchor)
            .onCenterY()
            .height(80)
            .width(80)
        
//        UIImage.load(from: pokemonImageUrl ?? "") { [weak self] image in
//            DispatchQueue.main.async { self?.pokemonImageView.image = image }
//        }
        
        containerView.addSubview(titleLabel)
        
        titleLabel
            .top(16, superView: containerView.topAnchor)
            .trailing(-16, superView: containerView.trailingAnchor)

        titleLabel.text = pokemonName ?? "missing name"

        containerView.addSubview(descriptionLabel)

        descriptionLabel
            .top(10, superView: titleLabel.bottomAnchor)
            .trailing(-16, superView: containerView.trailingAnchor)
        
        descriptionLabel.text = pokemonId ?? "missing id"
        
        containerView
            .bottom(16, superView: descriptionLabel.bottomAnchor)
        
        contentView
            .bottom(16, superView: descriptionLabel.bottomAnchor)
        
    }

}
