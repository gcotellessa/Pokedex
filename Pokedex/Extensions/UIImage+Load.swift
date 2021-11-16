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
    
    static func fetchImageData(urlString: String, completion: @escaping (String?) -> ()) {
        
        guard let imageURL = URL(string: urlString) else { DispatchQueue.main.async { completion(nil) }; return }
        
        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            } else if let data = data {
                let base64String = data.base64EncodedString(options: .endLineWithLineFeed)
                completion(base64String)
            }
        }
            
        task.resume()
    }
    
    static func load(from urlString: String, completion: @escaping (UIImage?) -> ()) {
        
        if let decodedData = Data(base64Encoded: urlString, options: NSData.Base64DecodingOptions()) {
            completion(UIImage(data: decodedData))
            return
        }
        
        guard let imageURL = URL(string: urlString) else { DispatchQueue.main.async { completion(nil) }; return }
        
        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in 
            if let error = error {
                print(error)
                completion(nil)
                return
            } else if let data = data {
                completion(UIImage(data: data))
            }
        }
            
        task.resume()
    }
    
}
