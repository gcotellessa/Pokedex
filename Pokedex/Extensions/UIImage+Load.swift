//
//  UIImage+Load.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation
import UIKit
import Combine

extension UIImage {
    
    private static var cancellables = Set<AnyCancellable>()
    
    static func load(from urlString: String, _ completion: @escaping (UIImage?) -> ()) {
        guard let imageURL = URL(string: urlString) else { DispatchQueue.main.async { completion(nil) }; return }
        let request = URLRequest(url: imageURL)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                return output.data
            }
            .tryMap { UIImage(data: $0) }
            .sink { result in
                switch result {
                    case let .success(image):
                        completion(image)
                    case .failure:
                        completion(nil)
                }
            }.store(in: &cancellables)
    }
}
