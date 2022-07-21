//
//  Networking.swift
//  LossList
//
//  Created by QwertY on 19.07.2022.
//

import Foundation

protocol Networking {
    func fetchEquipmentLosses(completion: @escaping(Result<[EquipmentLosses], ParseError>) -> Void) -> Void
    func fetchPersonnelLosses(completion: @escaping(Result<[PersonnelLosses], ParseError>) -> Void) -> Void
}
