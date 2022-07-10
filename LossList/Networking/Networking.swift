//
//  Networking.swift
//  LossList
//
//  Created by QwertY on 09.07.2022.
//

import Foundation

protocol Networking {
    func getResourceURL(for lossesType: LossesType) -> URL
    func fetchEquipmentLosses(completion: @escaping(Result<[EquipmentLosses], ParseError>) -> Void) -> Void
    func fetchPersonnelLosses(completion: @escaping(Result<[PersonnelLosses], ParseError>) -> Void) -> Void
}
