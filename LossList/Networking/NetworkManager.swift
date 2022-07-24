//
//  NetworkingManager.swift
//  LossList
//
//  Created by QwertY on 05.07.2022.
//

import Foundation

final class NetworkManager: Networking {

    private func getResourceURL<T>(for lossesType: T.Type) -> URL {
        switch lossesType {
        case is PersonnelLosses.Type:
            let resourceString = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json"
            guard let resourceURL = URL(string: resourceString) else { fatalError() }
            return resourceURL
        case is EquipmentLosses.Type:
            let resourceString = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json"
            guard let resourceURL = URL(string: resourceString) else { fatalError() }
            return resourceURL
        default:
            return URL(fileURLWithPath: "")
        }
    }
    
    public func fetchLosses<T: Decodable>(for lossesType: T.Type, completion: @escaping(Result<[T], ParseError>) -> Void) {
        let resourceURL = getResourceURL(for: lossesType)
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
                let losses = try decoder.decode([T].self, from: jsonData)
                completion(.success(losses))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
