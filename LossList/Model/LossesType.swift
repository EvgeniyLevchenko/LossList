//
//  LossesType.swift
//  LossList
//
//  Created by QwertY on 09.07.2022.
//

import Foundation

enum LossesType: Int, CaseIterable {
    case personnel = 0, tanks, aircraft, helicopters, APCs, fieldArtillery, MRLs, vehicles, drones, navalShips, antiAircraftWarfare, specialEquipment
    
    public static func getType(for value: Int) -> LossesType {
        switch value {
        case 0:
            return .personnel
        case 1:
            return .tanks
        case 2:
            return .aircraft
        case 3:
            return .helicopters
        case 4:
            return .APCs
        case 5:
            return .fieldArtillery
        case 6:
            return .MRLs
        case 7:
            return .vehicles
        case 8:
            return .drones
        case 9:
            return .navalShips
        case 10:
            return .antiAircraftWarfare
        default:
            return .specialEquipment
        }
    }
    
    public static func getLossesTypeName(for type: LossesType) -> String {
        switch type {
        case .personnel:
            return "Personnel"
        case .tanks:
            return "Tanks"
        case .aircraft:
            return "Aircraft"
        case .helicopters:
            return "Helicopters"
        case .APCs:
            return "APCs"
        case .fieldArtillery:
            return "Field artillery"
        case .MRLs:
            return "MRLs"
        case .vehicles:
            return "Vehicles and fuel tanks"
        case .drones:
            return "Drones"
        case .navalShips:
            return "Naval ships"
        case .antiAircraftWarfare:
            return "Anti-aircraft warfare"
        case .specialEquipment:
            return "Special equipment"
        }
    }
}
