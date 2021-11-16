//
//  Combine+Publisher.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 10/11/21.
//

import Foundation
import Combine

//extension Publisher {
//    func sink(to result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
//        sink { completion in
//            switch completion {
//            case let .failure(error): result(.failure(error))
//            case .finished: break
//            }
//        } receiveValue: { value in
//            result(.success(value))
//        }
//    }
//}
