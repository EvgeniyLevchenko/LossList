//
//  LossesDetailsPresenter.swift
//  LossList
//
//  Created by QwertY on 15.07.2022.
//

import UIKit

protocol LossesDetailsPresenterDelegate {
    func presentLosses(losses: Losses)
}

typealias DetailsPresenterDelegate = LossesDetailsPresenterDelegate & UIViewController

class LossesDetailsPresenter {
    weak var delegate: DetailsPresenterDelegate?
    
    public func setViewDelegate(delegate: DetailsPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func setLosses(losses: Losses) {
        delegate?.presentLosses(losses: losses)
    }
}
