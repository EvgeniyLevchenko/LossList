//
//  Configurable.swift
//  LossList
//
//  Created by QwertY on 19.07.2022.
//

import UIKit

@objc protocol Configurable {
    @objc optional func configure(lossesTypeImage: UIImage, lossesType: String, lossesNumber: Int)
    @objc optional func configure(lossesNumber: Int, newLosses: Int)
    @objc optional func configure(date: String)
}
