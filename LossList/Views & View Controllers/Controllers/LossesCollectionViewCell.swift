//
//  LossesCollectionViewCell.swift
//  LossList
//
//  Created by QwertY on 10.07.2022.
//

import UIKit

protocol Configurable {
    func configure(lossesTypeImage: UIImage, lossesType: String, lossesNumber: Int)
}

class LossesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var lossesTypeImageView: UIImageView!
    @IBOutlet private weak var lossesTypeLabel: UILabel!
    @IBOutlet private weak var lossesNumberLabel: UILabel!
    
    static let identifier = "LossesCollectionViewCell"
    
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension LossesCollectionViewCell: Configurable {
    
    func configure(lossesTypeImage: UIImage, lossesType: String, lossesNumber: Int) {
        lossesTypeImageView.image = lossesTypeImage
        lossesTypeLabel.text = lossesType
        lossesNumberLabel.text = String(lossesNumber)
    }
}
