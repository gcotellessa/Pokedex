//
//  URLSession+DataTask.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 16/11/21.
//

import Foundation

extension URLSession {
    func dataTask(with url: URL, handler: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        dataTask(with: url) { data, _, error in
            if let error = error {
                handler(.failure(error))
            } else {
                handler(.success(data ?? Data()))
            }
        }
    }
}
