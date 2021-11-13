//
//  ImagesCell.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 12/11/21.
//

import Foundation
import UIKit

class ImagesCell: UITableViewCell {
    
    static let identifier = "ImagesCell"

    var imagesURL: [String] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    override func prepareForReuse() {
        imagesURL = []
    }
    
    func setupLayout() {
        
        var marginLeft: CGFloat = 24
            
        imagesURL.forEach { imageUrl in
            
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .scaleToFill
    
            UIImage.load(from: imageUrl) { image in
                DispatchQueue.main.async { view.image = image }
            }
            
            contentView.addSubview(view)
            
            view.onCenterY()
                .leading(marginLeft, superView: contentView.leadingAnchor)
                .width(60)
                .height(60)
            
            marginLeft += 64
        }
        
        contentView.height(80)
        
    }

}
