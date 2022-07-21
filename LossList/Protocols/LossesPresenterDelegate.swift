//
//  LossesPresenterDelegate.swift
//  LossList
//
//  Created by QwertY on 19.07.2022.
//

import UIKit

protocol LossesPresenterDelegate: AnyObject {
    func presentEquipmentLosses()
    func presentPersonnelLosses()
    func presentErrorInfo(title: String, message: String)
    func presentInfo(title: String, message: String)
    func presentViewController(controller: UIViewController)
}

typealias PresenterDelegate = LossesPresenterDelegate & UIViewController
