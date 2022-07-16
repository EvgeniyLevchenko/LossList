//
//  MainViewPresenter.swift
//  LossList
//
//  Created by QwertY on 11.07.2022.
//

import UIKit

protocol LossesPresenterDelegate: AnyObject {
    func presentEquipmentLosses(equipment: [EquipmentLosses])
    func presentPersonnelLosses(personnel: [PersonnelLosses])
}

typealias PresenterDelegate = LossesPresenterDelegate & UIViewController

class LossesPresenter {
    weak var delegate: PresenterDelegate?
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getLossesInfo() {
        let networkManager = NetworkManager()
        
        networkManager.fetchEquipmentLosses(completion: { result in
            switch result {
            case .success(let equipment):
                DispatchQueue.main.async {
                    self.delegate?.presentEquipmentLosses(equipment: equipment)
                }
            case .failure(_):
                print("error")
                // to do
            }
        })
        
        networkManager.fetchPersonnelLosses(completion: { result in
            switch result {
            case .success(let personnel):
                DispatchQueue.main.async {
                    self.delegate?.presentPersonnelLosses(personnel: personnel)
                }
            case .failure(_):
                print("error")
                // to do
            }
        })
    }
    
    public func configure(cell: LossesCollectionViewCell, with losses: Losses, atRow row: Int) {
        let lossesType = LossesType.getType(for: row)
        let lossesTypeStr = LossesType.getLossesTypeName(for: lossesType)
        if let lossesTypeImage = UIImage(named: lossesTypeStr),
           let lossesNumber = losses.getLosses(forLossesType: lossesType) {
            cell.configure(lossesTypeImage: lossesTypeImage, lossesType: lossesTypeStr, lossesNumber: lossesNumber)
        } else {
          // to do
        }
    }
    
    public func presentInfo(for losses: Losses) {
        let title = "Description"
        let date = losses.equipment.last?.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateStr = dateFormatter.string(from: date!)
        let message = "Losses of Russians troops on the territory of Ukraine. Data was last updated on \(dateStr)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(alertAction)
        delegate?.present(alert, animated: true)
    }
    
    public func presentDetailsVC(with losses: Losses, forCellAtIndex index: Int) {
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: DetailsViewController.identifier) as! DetailsViewController
        delegate?.navigationController?.pushViewController(detailsVC, animated: true)
        detailsVC.viewDidLoad()
        let presenter = detailsVC.getPresenter()
        presenter.setLosses(losses: losses)
    }
}
