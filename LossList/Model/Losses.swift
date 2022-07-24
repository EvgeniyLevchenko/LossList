//
//  Losses.swift
//  LossList
//
//  Created by QwertY on 11.07.2022.
//

import Foundation

struct Losses: LossesAccessing {
    public var personnel: [PersonnelLosses] = []
    public var equipment: [EquipmentLosses] = []

    public var daysNumber: Int {
        get {
            equipment.count
        }
    }
    
    public var monthsNumber: Int {
        get {
            guard let firstDate = equipment.first?.date else { return 0 }
            guard let lastDate = equipment.last?.date else { return 0}
            let calendar = Calendar.current
            var components = calendar.dateComponents([.month], from: firstDate)
            guard let firstMonth = components.month else { return 0 }
            components = calendar.dateComponents([.month], from: lastDate)
            guard let lastMonth = components.month else { return 0 }
            let monthsNumber = lastMonth - firstMonth + 1
            return monthsNumber
        }
    }
    
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
    
    public func getLosses(forDay dayNumber: Int, forLossesType type: LossesType?) -> Int {
        if (dayNumber < 0) {
            return 0
        }
        
        switch type {
        case .personnel:
            return self.personnel[dayNumber].personnel
        case .tanks:
            return self.equipment[dayNumber].tank
        case .aircraft:
            return self.equipment[dayNumber].aircraft
        case .helicopters:
            return self.equipment[dayNumber].helicopter
        case .APCs:
            return self.equipment[dayNumber].apc
        case .fieldArtillery:
            return self.equipment[dayNumber].fieldArtillery
        case .MRLs:
            return self.equipment[dayNumber].mrl
        case .vehicles:
            return self.equipment[dayNumber].vehiclesAndFuelTanks
        case .drones:
            return self.equipment[dayNumber].drone
        case .navalShips:
            return self.equipment[dayNumber].navalShip
        case .antiAircraftWarfare:
            return self.equipment[dayNumber].antiAircraftWarfare
        case .specialEquipment:
            return self.equipment[dayNumber].specialEquipment
        default:
            return 0
        }
    }
    
    public func getLosses(forMonth monthsNumber: Int, forLossesType type: LossesType?) -> Int {
        if monthsNumber < 0 {
            return 0
        }
        
        let calendar = Calendar.current
        let firstDate = equipment[0].date
        var components = calendar.dateComponents([.year, .month], from: firstDate)
        guard let monthValue = components.month else { return 0 }
        components.setValue(monthValue + monthsNumber + 1, for: .month)
        components.day = 1
        guard let endOfMonth = calendar.date(from: components) else { return 0 }
        var endOfMonthIndex: Int
        if let index = equipment.firstIndex(where: { $0.date == endOfMonth }) {
            endOfMonthIndex = index
        } else {
            endOfMonthIndex = equipment.endIndex - 1
        }

        switch type {
        case .personnel:
            return self.personnel[endOfMonthIndex].personnel
        case .tanks:
            return self.equipment[endOfMonthIndex].tank
        case .aircraft:
            return self.equipment[endOfMonthIndex].aircraft
        case .helicopters:
            return self.equipment[endOfMonthIndex].helicopter
        case .APCs:
            return self.equipment[endOfMonthIndex].apc
        case .fieldArtillery:
            return self.equipment[endOfMonthIndex].fieldArtillery
        case .MRLs:
            return self.equipment[endOfMonthIndex].mrl
        case .vehicles:
            return self.equipment[endOfMonthIndex].vehiclesAndFuelTanks
        case .drones:
            return self.equipment[endOfMonthIndex].drone
        case .navalShips:
            return self.equipment[endOfMonthIndex].navalShip
        case .antiAircraftWarfare:
            return self.equipment[endOfMonthIndex].antiAircraftWarfare
        case .specialEquipment:
            return self.equipment[endOfMonthIndex].specialEquipment
        default:
            return 0
        }
    }
    
    public func getMonth(withNumber number: Int) -> String {
        let firstDate = equipment[0].date
        let calendar = Calendar.current
        if let month = calendar.date(byAdding: .month, value: number, to: firstDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            let strMonth = formatter.string(from: month)
            return strMonth
        } else {
            return ""
        }
    }
    
    public func getDay(withNumber number: Int) -> String {
        let dayNumber = equipment[number].day
        let day = "Day \(dayNumber)"
        return day
    }
}
