//
//  PersonnelLosses.swift
//  LossList
//
//  Created by QwertY on 05.07.2022.
//

import Foundation

struct PersonnelLosses: Codable {
    let date: Date
    let day: Int
    let personnel: Int
    let note: String
    let pow: Int
    
    enum CodingKeys: String, CodingKey{
        case date = "date"
        case day = "day"
        case personnel = "personnel"
        case note = "personnel*"
        case pow = "POW"
    }
}
