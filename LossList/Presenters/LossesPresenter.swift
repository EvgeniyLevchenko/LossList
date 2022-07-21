//
//  MainViewPresenter.swift
//  LossList
//
//  Created by QwertY on 11.07.2022.
//

import UIKit

final class LossesPresenter {
    public weak var delegate: PresenterDelegate?
    private var losses = Losses()
    private var dataIsAvailable = true
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getLossesInfo() {
        let networkManager = NetworkManager()
        
        networkManager.fetchEquipmentLosses(completion: { result in
            switch result {
            case .success(let equipment):
                DispatchQueue.main.async {
                    self.losses.equipment = equipment
                    self.dataIsAvailable = true
                    self.delegate?.presentEquipmentLosses()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentErrorInfo(error: error)
                    self.dataIsAvailable = false
                }
            }
        })
        
        networkManager.fetchPersonnelLosses(completion: { result in
            switch result {
            case .success(let personnel):
                DispatchQueue.main.async {
                    self.losses.personnel = personnel
                    self.dataIsAvailable = true
                    self.delegate?.presentPersonnelLosses()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentErrorInfo(error: error)
                    self.dataIsAvailable = false
                }
            }
        })
    }
    
    private func presentErrorInfo(error: ParseError) {
        let title = "Error"
        var message = ""
        switch error {
        case .noDataAvailable:
            message = "Something went wrong! Check your Internet connection."
        case .canNotProcessData:
            message = "Something went wrong! We are working on it."
        }
        delegate?.presentErrorInfo(title: title, message: message)
    }
    
    public func presentInfo() {
        if dataIsAvailable == true {
            let title = "Description"
            let date = losses.equipment.last?.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            let dateStr = dateFormatter.string(from: date!)
            let message = "Losses of Russians troops on the territory of Ukraine. Data was last updated on \(dateStr)"
            delegate?.presentInfo(title: title, message: message)
        } else {
            let title = "Description"
            let message = "Losses of Russians troops on the territory of Ukraine. Data is not available right now."
            delegate?.presentInfo(title: title, message: message)
            
        }
    }
    
    public func configure(cell: LossesCollectionViewCell, atRow row: Int) {
        let lossesType = LossesType.getType(for: row)
        let lossesTypeStr = LossesType.getLossesTypeName(for: lossesType)
        if let lossesTypeImage = UIImage(named: lossesTypeStr),
           let lossesNumber = losses.getLosses(forLossesType: lossesType) {
            cell.configure(lossesTypeImage: lossesTypeImage, lossesType: lossesTypeStr, lossesNumber: lossesNumber)
        } else {
            cell.configure(lossesTypeImage: UIImage(named: lossesTypeStr)!, lossesType: lossesTypeStr, lossesNumber: 0)
        }
    }
    
    public func presentDetailsVC(forCellAtIndex index: Int) {
        if dataIsAvailable == true {
            let storyboardName = "Main"
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            let detailsVC = storyboard.instantiateViewController(withIdentifier: DetailsViewController.identifier) as! DetailsViewController
            delegate?.presentViewController(controller: detailsVC)
            let presenter = detailsVC.getPresenter()
            presenter.setLosses(losses: losses, lossesTypeIndex: index)
        }
    }
}
