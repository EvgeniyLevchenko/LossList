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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try container.decode(Date.self, forKey: .date)
        day = try container.decode(Int.self, forKey: .day)
        personnel = try container.decode(Int.self, forKey: .personnel)
        note = try container.decode(String.self, forKey: .note)
        
        do {
            pow = try container.decode(Int.self, forKey: .pow)
        } catch {
            pow = 0
        }
    }
}
