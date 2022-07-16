//
//  DetailsViewController.swift
//  LossList
//
//  Created by QwertY on 15.07.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    public static let identifier = "DetailsViewController"
    
    private var losses = Losses()
    private let presenter = LossesDetailsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
    }
    
    public func getPresenter() -> LossesDetailsPresenter {
        presenter
    }
}

extension DetailsViewController: LossesDetailsPresenterDelegate {
    
    private func setupPresenter() {
        presenter.setViewDelegate(delegate: self)
    }
    
    func presentLosses(losses: Losses) {
        self.losses = losses
    }
}
