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
    
    enum CodingKeys: String, CodingKey {
        case date
        case day
        case aircraft
        case helicopter
        case tank
        case apc = "APC"
        case fieldArtillery = "field artillery"
        case mrl = "MRL"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMsystem = "mobile SRBM system"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
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
        militaryAuto = try container.decode(Int.self, forKey: .militaryAuto)
        fuelTank = try container.decode(Int.self, forKey: .fuelTank)
        drone = try container.decode(Int.self, forKey: .drone)
        navalShip = try container.decode(Int.self, forKey: .navalShip)
        antiAircraftWarfare = try container.decode(Int.self, forKey: .antiAircraftWarfare)
        
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
            let value = try container.decode(Int.self, forKey: .day)
            day = value
        } catch {
            let value = try container.decode(String.self, forKey: .day)
            let intValue = Int(value) ?? 0
            day = intValue
        }
    }
}