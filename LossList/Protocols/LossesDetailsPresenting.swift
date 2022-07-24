//
//  LossesDetailsPresenting.swift
//  LossList
//
//  Created by QwertY on 24.07.2022.
//

import Foundation

protocol LossesDetailsPresenting {
    func setViewDelegate(delegate: DetailsPresenterDelegate)
    func setLosses(losses: Losses, lossesTypeIndex: Int)
    func getLossesInfo()
    func getNumberOfRows(for segment: Segment) -> Int
    func configure(cell: Configurable, atRow row: Int, forSegment segment: Segment)
}
