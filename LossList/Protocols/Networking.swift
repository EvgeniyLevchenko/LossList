//
//  Networking.swift
//  LossList
//
//  Created by QwertY on 19.07.2022.
//

import Foundation

protocol Networking {
    func fetchLosses<T: Decodable>(for lossesType: T.Type, completion: @escaping(Result<[T], ParseError>) -> Void) -> Void
}
