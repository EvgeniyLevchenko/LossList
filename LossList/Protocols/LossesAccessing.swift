//
//  LossesAccessing.swift
//  LossList
//
//  Created by QwertY on 24.07.2022.
//

import Foundation

protocol LossesAccessing {
    func getLosses(forLossesType type: LossesType) -> Int?
    func getLosses(forDay dayNumber: Int, forLossesType type: LossesType?) -> Int
    func getLosses(forMonth monthsNumber: Int, forLossesType type: LossesType?) -> Int
    func getMonth(withNumber number: Int) -> String
    func getDay(withNumber number: Int) -> String
}
