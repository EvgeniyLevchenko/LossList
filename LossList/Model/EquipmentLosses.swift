//
//  EquipmentLosses.swift
//  LossList
//
//  Created by QwertY on 05.07.2022.
//

import Foundation

struct EquipmentLosses: Codable {
    let date: Date
    let day: Int
    let aircraft: Int
    let helicopter: Int
    let tank: Int
    let apc: Int
    let fieldArtillery: Int
    let mrl: Int
    let militaryAuto: Int
    let fuelTank: Int
    let drone: Int
    let navalShip: Int
    let antiAircraftWarfare: Int
    let specialEquipment: Int
    let mobileSRBMsystem: Int
    let vehiclesAndFuelTanks: Int
    let cruiseMissiles: Int
    let greatestLossesDirection: String
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case date = "date"
        case day = "day"
        case aircraft = "aircraft"
        case helicopter = "helicopter"
        case tank = "tank"
        case apc = "APC"
        case fieldArtillery = "field artillery"
        case mrl = "MRL"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone = "drone"
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMsystem = "mobile SRBM system"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
        case greatestLossesDirection = "greatest losses direction"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try container.decode(Date.self, forKey: .date)
        aircraft = try container.decode(Int.self, forKey: .aircraft)
        helicopter = try container.decode(Int.self, forKey: .helicopter)
        tank = try container.decode(Int.self, forKey: .tank)
        apc = try container.decode(Int.self, forKey: .apc)
        fieldArtillery = try container.decode(Int.self, forKey: .fieldArtillery)
        mrl = try container.decode(Int.self, forKey: .mrl)
        drone = try container.decode(Int.self, forKey: .drone)
        navalShip = try container.decode(Int.self, forKey: .navalShip)
        antiAircraftWarfare = try container.decode(Int.self, forKey: .antiAircraftWarfare)
        
        do {
            militaryAuto = try container.decode(Int.self, forKey: .militaryAuto)
        } catch {
            militaryAuto = 0
        }
        
        do {
            fuelTank = try container.decode(Int.self, forKey: .fuelTank)
        } catch {
            fuelTank = 0
        }
        
        do {
            specialEquipment = try container.decode(Int.self, forKey: .specialEquipment)
        } catch {
            specialEquipment = 0
        }
        
        do {
            mobileSRBMsystem = try container.decode(Int.self, forKey: .mobileSRBMsystem)
        }
        catch {
            mobileSRBMsystem = 0
        }
        
        do {
            vehiclesAndFuelTanks = try container.decode(Int.self, forKey: .vehiclesAndFuelTanks)
        }
        catch {
            vehiclesAndFuelTanks = 0
        }
        
        do {
            cruiseMissiles = try container.decode(Int.self, forKey: .cruiseMissiles)
        } catch {
            cruiseMissiles = 0
        }
        
        do {
            greatestLossesDirection = try container.decode(String.self, forKey: .greatestLossesDirection)
        } catch {
            greatestLossesDirection = ""
        }
        
        do {
            let value = try container.decode(Int.self, forKey: .day)
            day = value
        } catch {
            let value = try container.decode(String.self, forKey: .day)
            let intValue = Int(value) ?? 0
            day = intValue
        }
    }
}
