//
//  Losses.swift
//  LossList
//
//  Created by QwertY on 11.07.2022.
//

import Foundation

struct Losses {
    var personnel: [PersonnelLosses] = []
    var equipment: [EquipmentLosses] = []
    
    public func getLosses(forLossesType type: LossesType) -> Int? {
        switch type {
        case .personnel:
            return self.personnel.last?.personnel
        case .tanks:
            return self.equipment.last?.tank
        case .aircraft:
            return self.equipment.last?.aircraft
        case .helicopters:
            return self.equipment.last?.helicopter
        case .APCs:
            return self.equipment.last?.apc
        case .fieldArtillery:
            return self.equipment.last?.fieldArtillery
        case .MRLs:
            return self.equipment.last?.mrl
        case .vehicles:
            return self.equipment.last?.vehiclesAndFuelTanks
        case .drones:
            return self.equipment.last?.drone
        case .navalShips:
            return self.equipment.last?.navalShip
        case .antiAircraftWarfare:
            return self.equipment.last?.antiAircraftWarfare
        case .specialEquipment:
            return self.equipment.last?.specialEquipment
        }
    }
}
