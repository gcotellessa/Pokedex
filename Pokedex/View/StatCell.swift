//
//  StatCell.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 12/11/21.
//

import Foundation
import UIKit

class StatCell: UITableViewCell {
    
    static let identifier = "StatCell"
    
    private lazy var keyLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .gray
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    var statKey = "prova"
    var statValue = "prova"

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    override func prepareForReuse() {
        statKey = ""
        statValue = ""
    }
    
    func setupLayout() {
        
        contentView.addSubview(keyLabel)
        
        keyLabel
            .top(16, superView: contentView.topAnchor)
            .leading(16, superView: contentView.leadingAnchor)
        
        keyLabel.text = statKey
        
        contentView.addSubview(valueLabel)
        
        valueLabel
            .top(16, superView: contentView.topAnchor)
            .trailing(-16, superView: contentView.trailingAnchor)
        
        valueLabel.text = statValue
        
        contentView
            .bottom(16, superView: keyLabel.bottomAnchor)
    }

}
