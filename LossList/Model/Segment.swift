//
//  Segment.swift
//  LossList
//
//  Created by QwertY on 19.07.2022.
//

import Foundation

enum Segment: Int {
    case monthly = 0
    case daily = 1
    
    static func getSegment(for value: Int) -> Segment {
        switch value {
        case 0:
            return .monthly
        case 1:
            return .daily
        default:
            return .monthly
        }
    }
}
