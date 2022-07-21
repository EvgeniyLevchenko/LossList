//
//  LossesDetailsPresenter.swift
//  LossList
//
//  Created by QwertY on 15.07.2022.
//

import UIKit

final class LossesDetailsPresenter {
    public weak var delegate: DetailsPresenterDelegate?
    private var losses = Losses()
    private var lossesType: LossesType?
    
    public func setViewDelegate(delegate: DetailsPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func setLosses(losses: Losses, lossesTypeIndex: Int) {
        self.losses = losses
        self.lossesType = LossesType.getType(for: lossesTypeIndex)
    }
    
    public func getLossesInfo() {
        let lossesTypeStr = LossesType.getLossesTypeName(for: lossesType!)
        if let lossesTypeImage = UIImage(named: lossesTypeStr),
           let lossesNumber = losses.getLosses(forLossesType: lossesType!) {
            delegate?.presentLosses(lossesTypeImage: lossesTypeImage, lossesType: lossesTypeStr, lossesNumber: lossesNumber)
        }
    }
    
    public func getNumberOfRows(for segment: Segment) -> Int {
        let daysNumber = losses.daysNumber
        let monthsNumber = losses.monthsNumber
        switch segment {
        case .daily:
            return 2 * daysNumber
        case .monthly:
            return 2 * monthsNumber
        }
    }
    
    public func configure(cell: DateTableViewCell, atRow row: Int, forSegment segment: Segment) {
        switch segment {
        case .monthly:
            let monthStr = losses.getMonth(withNumber: row)
            cell.configure(date: monthStr)
        case .daily:
            let dayStr = losses.getDay(withNumber: row)
            cell.configure(date: dayStr)
        }
    }
    
    public func configure(cell: LossesTableViewCell, atRow row: Int, forSegment segment: Segment) {
        switch segment {
        case .monthly:
            let previousLosses = losses.getLosses(forMonth: row - 1, forLossesType: lossesType)
            let currentLosses = losses.getLosses(forMonth: row, forLossesType: lossesType)
            let newLosses = currentLosses - previousLosses
            cell.configure(lossesNumber: currentLosses, newLosses: newLosses)
        case .daily:
            let previousLosses = losses.getLosses(forDay: row - 1, forLossesType: lossesType)
            let currentLosses = losses.getLosses(forDay: row, forLossesType: lossesType)
            let newLosses = currentLosses - previousLosses
            cell.configure(lossesNumber: currentLosses, newLosses: newLosses)
        }
    }
}
