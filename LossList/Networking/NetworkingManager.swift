//
//  NetworkingManager.swift
//  LossList
//
//  Created by QwertY on 05.07.2022.
//

import Foundation

class NetworkingManager: Networking {

    internal func getResourceURL(for lossesType: LossesType) -> URL {
        var resourceString: String
        switch lossesType {
        case .equipment:
            resourceString = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json"
        case .personnel:
            resourceString = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json"
        }
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        return resourceURL
    }
    
    public func fetchEquipmentLosses(completion: @escaping(Result<[EquipmentLosses], ParseError>) -> Void) {
        let resourceURL = getResourceURL(for: .equipment)
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let strData = String(decoding: jsonData, as: UTF8.self)
                let correctedStrData = strData.replacingOccurrences(of: "NaN", with: "0")
                if let correctedJsonData = correctedStrData.data(using: .utf8) {
                    let decoder = JSONDecoder()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    let equipmentLosses = try decoder.decode([EquipmentLosses].self, from: correctedJsonData)
                    completion(.success(equipmentLosses))
                }
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    public func fetchPersonnelLosses(completion: @escaping(Result<[PersonnelLosses], ParseError>) -> Void) {
        let resourceURL = getResourceURL(for: .personnel)
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let personnelLosses = try decoder.decode([PersonnelLosses].self, from: jsonData)
                completion(.success(personnelLosses))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
