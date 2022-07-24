//
//  LossesDetailsPresenter.swift
//  LossList
//
//  Created by QwertY on 15.07.2022.
//

import UIKit

final class LossesDetailsPresenter: LossesDetailsPresenting {
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
        guard let lossesType = lossesType else { return }
        let lossesTypeStr = LossesType.getLossesTypeName(for: lossesType)
        if let lossesTypeImage = UIImage(named: lossesTypeStr),
           let lossesNumber = losses.getLosses(forLossesType: lossesType) {
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
    
    func configure(cell: Configurable, atRow row: Int, forSegment segment: Segment) {
        switch type(of: cell) {
        case is DateTableViewCell.Type:
            let customCell = cell as! DateTableViewCell
            
            switch segment {
            case .monthly:
                let monthStr = losses.getMonth(withNumber: row)
                customCell.configure(date: monthStr)
            case .daily:
                let dayStr = losses.getDay(withNumber: row)
                customCell.configure(date: dayStr)
            }
        case is LossesTableViewCell.Type:
            let customCell = cell as! LossesTableViewCell
            
            switch segment {
            case .monthly:
                let previousLosses = losses.getLosses(forMonth: row - 1, forLossesType: lossesType)
                let currentLosses = losses.getLosses(forMonth: row, forLossesType: lossesType)
                let newLosses = currentLosses - previousLosses
                customCell.configure(lossesNumber: currentLosses, newLosses: newLosses)
            case .daily:
                let previousLosses = losses.getLosses(forDay: row - 1, forLossesType: lossesType)
                let currentLosses = losses.getLosses(forDay: row, forLossesType: lossesType)
                let newLosses = currentLosses - previousLosses
                customCell.configure(lossesNumber: currentLosses, newLosses: newLosses)
            }
        default:
            return
        }
    }
}
