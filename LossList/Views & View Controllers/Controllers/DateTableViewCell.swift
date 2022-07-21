//
//  DateTableViewCell.swift
//  LossList
//
//  Created by QwertY on 18.07.2022.
//

import UIKit

final class DateTableViewCell: UITableViewCell {

    @IBOutlet private weak var dateLabel: UILabel!
    
    static let identifier = "DateTableViewCell"
    
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
}

extension DateTableViewCell: Configurable {
    func configure(date: String) {
        dateLabel.text = date
    }
}
