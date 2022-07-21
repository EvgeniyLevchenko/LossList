//
//  LossesTableViewCell.swift
//  LossList
//
//  Created by QwertY on 18.07.2022.
//

import UIKit

final class LossesTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var lossesLabel: UILabel!
    @IBOutlet private weak var newLossesLabel: UILabel!
    
    static let identifier = "LossesTableViewCell"

    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
}

extension LossesTableViewCell: Configurable {
    func configure(lossesNumber: Int, newLosses: Int) {
        lossesLabel.text = String(lossesNumber)
        newLossesLabel.text = "+\(newLosses)"
    }
}
