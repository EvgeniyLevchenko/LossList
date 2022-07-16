//
//  ViewController.swift
//  LossList
//
//  Created by QwertY on 03.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var lossesCollectionView: UICollectionView!
    
    private var losses = Losses()
    private let presenter = LossesPresenter()
    private let refreshControl = UIRefreshControl()
    
    @IBAction func descriptionButtonTapped(_ sender: Any) {
        presenter.presentInfo(for: losses)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPresenter()
    }
}

// MARK: - Losses Presenter Delegate
extension MainViewController: LossesPresenterDelegate {

    private func setupPresenter() {
        presenter.setViewDelegate(delegate: self)
        presenter.getLossesInfo()
    }
    
    func presentEquipmentLosses(equipment: [EquipmentLosses]) {
        losses.equipment = equipment
        DispatchQueue.main.async {
            self.lossesCollectionView.reloadData()
        }
    }
    
    func presentPersonnelLosses(personnel: [PersonnelLosses]) {
        losses.personnel = personnel
        DispatchQueue.main.async {
            self.lossesCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionView Data Source & Delegates
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LossesType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LossesCollectionViewCell.identifier, for: indexPath) as! LossesCollectionViewCell
        presenter.configure(cell: cell, with: losses, atRow: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.presentDetailsVC(with: losses, forCellAtIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = 25.0
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2.0, height: collectionViewSize / 2.0)
    }
}

// MARK: - UI Setup
extension MainViewController {
    
    private func setupUI() {
        setupLossesCollectionView()
        setupRefreshControl()
    }
    
    private func setupLossesCollectionView() {
        lossesCollectionView.dataSource = self
        lossesCollectionView.delegate = self
        lossesCollectionView.register(LossesCollectionViewCell.nib(), forCellWithReuseIdentifier: LossesCollectionViewCell.identifier)
    }
    
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Updating data")
        refreshControl.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        lossesCollectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshCollectionView() {
        presenter.getLossesInfo()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.refreshControl.endRefreshing()
        }
    }
}
