//
//  LossesTypeAccessing.swift
//  LossList
//
//  Created by QwertY on 24.07.2022.
//

import Foundation

protocol LossesTypeAccessing {
    static func getType(for value: Int) -> LossesType
    static func getLossesTypeName(for type: LossesType) -> String
}
