//
//  UIView+Layout.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 09/11/21.
//

import Foundation
import UIKit

extension UIView {
    
    //MARK: Constraints
    func equalToSuperview() {
        self.top().bottom().leading().trailing()
    }
    
    func anchor(to view: UIView, safeArea: Bool = true) {
        if safeArea {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor),
                topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor),
                topAnchor.constraint(equalTo: view.topAnchor),
                bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    
    func updateConstraint(attribute: NSLayoutConstraint.Attribute, constant: CGFloat) {
        if let constraint = (constraints.filter{$0.firstAttribute == attribute}.first) {
            constraint.constant = constant
        }
    }
    
    func getConstant(of attribute: NSLayoutConstraint.Attribute) -> CGFloat {
        if let constraint = (constraints.filter{$0.firstAttribute == attribute}.first) {
            return constraint.constant
        }
        return 0
    }
    
    @discardableResult
    func onCenterY() -> Self {
        if let superview = superview {
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        }
        return self
    }
    
    @discardableResult
    func onCenterX() -> Self {
        if let superview = superview {
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        }
        return self
    }
    
    @discardableResult
    func width(_ const: CGFloat? = nil, superView: NSLayoutDimension? = nil, multiplier: CGFloat = 1) -> Self {
        if let const = const {
            self.widthAnchor.constraint(equalToConstant: const).isActive = true
        }
        
        if let superView = superView {
            self.widthAnchor.constraint(equalTo: superView, multiplier: 1).isActive = true
        }
        
        if let superview = superview, const == nil, superView == nil {
            self.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 1).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func height(_ const: CGFloat? = nil, superView: NSLayoutDimension? = nil, multiplier: CGFloat = 1) -> Self {
        if let const = const, !const.isNaN {
            self.heightAnchor.constraint(equalToConstant: const).isActive = true
        }
        
        if let superView = superView {
            self.heightAnchor.constraint(equalTo: superView, multiplier: 1).isActive = true
        }
        
        if let superview = superview, const == nil, superView == nil {
            self.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 1).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func leading(_ const: CGFloat? = nil, superView: NSLayoutXAxisAnchor? = nil) -> Self {
        if let superView = superView, let const = const {
            self.leadingAnchor.constraint(equalTo: superView, constant: const).isActive = true
            return self
        }
        
        if let superview = superview, let const = const {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: const).isActive = true
        }
        
        if let superview = superview, const == nil, superView == nil {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func trailing(_ const: CGFloat? = nil, superView: NSLayoutXAxisAnchor? = nil) -> Self {
        if let superView = superView, let const = const {
            self.trailingAnchor.constraint(equalTo: superView, constant: const).isActive = true
            return self
        }
        
        if let const = const, let superview = superview {
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: const).isActive = true
        }
        
        if let superview = superview, const == nil, superView == nil {
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func top(_ const: CGFloat? = nil, superView: NSLayoutYAxisAnchor? = nil) -> Self {
        if let superView = superView, let const = const {
            self.topAnchor.constraint(equalTo: superView, constant: const).isActive = true
            return self
        }
        
        if let superview = superview, let const = const {
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: const).isActive = true
        }
        
        if let superview = superview, const == nil, superView == nil {
            self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func bottom(_ const: CGFloat? = nil, superView: NSLayoutYAxisAnchor? = nil) -> Self {
        if let superView = superView, let const = const {
            self.bottomAnchor.constraint(equalTo: superView, constant: const).isActive = true
            return self
        }
        
        if let const = const {
            if let superview = superview {
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: const).isActive = true
            }
        }
        
        if let superview = superview, const == nil, superView == nil {
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
        
        return self
    }
    
    
    //MARK: Borders
    @discardableResult
    func addBottomBorder(with color: UIColor, and height: CGFloat) -> UIView {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = color
        
        self.addSubview(border)
        
        NSLayoutConstraint.activate([
            border.heightAnchor.constraint(equalToConstant: height),
            border.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            border.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        return border
    }
}
