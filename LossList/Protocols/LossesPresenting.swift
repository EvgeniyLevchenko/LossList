//
//  LossesPresenting.swift
//  LossList
//
//  Created by QwertY on 24.07.2022.
//

import Foundation

protocol LossesPresenting {
    func setViewDelegate(delegate: PresenterDelegate)
    func getLossesInfo()
    func presentErrorInfo(error: ParseError)
    func presentInfo()
    func configure(cell: Configurable, atRow row: Int)
    func presentDetailsVC(forCellAtIndex index: Int)
}
