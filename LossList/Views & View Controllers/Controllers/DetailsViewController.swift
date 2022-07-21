//
//  DetailsViewController.swift
//  LossList
//
//  Created by QwertY on 15.07.2022.
//

import UIKit

final class DetailsViewController: UIViewController {

    @IBOutlet weak var lossesTypeImageView: UIImageView!
    @IBOutlet weak var lossesNumber: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var lossesTableView: UITableView!
    
    public static let identifier = "DetailsViewController"
    private let presenter = LossesDetailsPresenter()
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        reloadLossesTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPresenter()
    }
    
    public func getPresenter() -> LossesDetailsPresenter {
        presenter.setViewDelegate(delegate: self)
        return presenter
    }
    
    private func reloadLossesTableView() {
        lossesTableView.reloadData()
    }
}

// MARK: - Losses Details Presenter Delegate
extension DetailsViewController: LossesDetailsPresenterDelegate {

    private func setupPresenter() {
        presenter.getLossesInfo()
    }
    
    func presentLosses(lossesTypeImage: UIImage, lossesType: String, lossesNumber: Int) {
        self.lossesTypeImageView.image = lossesTypeImage
        self.title = lossesType
        self.lossesNumber.text = "General losses: \(lossesNumber)"
    }
}

// MARK: - UITableView Data Source
extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        let selectedSegment = Segment.getSegment(for: selectedSegmentIndex)
        return presenter.getNumberOfRows(for: selectedSegment)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        let selectedSegment = Segment.getSegment(for: selectedSegmentIndex)
        switch indexPath.row.isMultiple(of: 2) {
        case true:
            let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as! DateTableViewCell
            presenter.configure(cell: cell, atRow: indexPath.row / 2, forSegment: selectedSegment)
            return cell
        case false:
            let cell = tableView.dequeueReusableCell(withIdentifier: LossesTableViewCell.identifier, for: indexPath) as! LossesTableViewCell
            presenter.configure(cell: cell, atRow: indexPath.row / 2, forSegment: selectedSegment)
            return cell
        }
    }
}

// MARK: - UI setup
extension DetailsViewController {
    
    private func setupUI() {
        setupLossesTableView()
    }
    
    private func setupLossesTableView() {
        lossesTableView.dataSource = self
        lossesTableView.register(DateTableViewCell.nib(), forCellReuseIdentifier: DateTableViewCell.identifier)
        lossesTableView.register(LossesTableViewCell.nib(), forCellReuseIdentifier: LossesTableViewCell.identifier)
        lossesTableView.tableFooterView = UIView()
    }
}
