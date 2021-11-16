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
    
//    private static var cancellables = Set<AnyCancellable>()
//    
//    static func load(from urlString: String, _ completion: @escaping (UIImage?) -> ()) {
//        
//        if let decodedData = Data(base64Encoded: urlString, options: NSData.Base64DecodingOptions()) {
//            completion(UIImage(data: decodedData))
//            return
//        }
//        
//        guard let imageURL = URL(string: urlString) else { DispatchQueue.main.async { completion(nil) }; return }
//        let request = URLRequest(url: imageURL)
//        
//        URLSession.shared.dataTaskPublisher(for: request)
//            .tryMap { output -> Data in
//                return output.data
//            }
//            .tryMap { UIImage(data: $0) }
//            .sink { result in
//                switch result {
//                    case let .success(image):
//                        completion(image)
//                    case .failure:
//                        completion(nil)
//                }
//            }.store(in: &cancellables)
//    }
//    
//    static func fetchImageData(urlString: String, completion: @escaping (String?) -> ()) {
//        guard let imageURL = URL(string: urlString) else { DispatchQueue.main.async { completion(nil) }; return }
//        let request = URLRequest(url: imageURL)
//        URLSession.shared.dataTaskPublisher(for: request)
//            .tryMap { output -> Data in
//                return output.data
//            }.sink { result in
//                switch result {
//                    case let .success(data):
//                    let base64String = data.base64EncodedString(options: .endLineWithLineFeed)
//                    completion(base64String)
//                    case .failure:
//                        completion(nil)
//                }
//            }.store(in: &cancellables)
//    }
    
}
