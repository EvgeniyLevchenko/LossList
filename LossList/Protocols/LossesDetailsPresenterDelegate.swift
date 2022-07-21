//
//  LossesDetailsPresenterDelegate.swift
//  LossList
//
//  Created by QwertY on 19.07.2022.
//

import UIKit

protocol LossesDetailsPresenterDelegate {
    func presentLosses(lossesTypeImage: UIImage, lossesType: String, lossesNumber: Int)
}

typealias DetailsPresenterDelegate = LossesDetailsPresenterDelegate & UIViewController

