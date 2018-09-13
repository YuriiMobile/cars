//
//  CarsListViewController.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import UIKit

protocol CarsListView: class {
    
    func reloadData()
    func insertCells(at indexes: InsertIndexes?)
    
}

class CarsListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!
    
    private lazy var presenter: CarListPresenter = CarListPresenterImp(carsListView: self, paginationDelegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        tableView.tableFooterView = activityIndicator
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        activityIndicator.frame = CGRect(origin: .zero, size: CGSize(width: tableView.frame.width, height: 44))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let carDescriptionController = segue.destination as? CarDescriptionViewController,
            let car = sender as? Car {
            carDescriptionController.presenter = CarDescriptionPresenterImp(car: car)
        }
    }
    
}

extension CarsListViewController: CarsListView {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func insertCells(at indexes: InsertIndexes?) {
        guard let validIndexes = indexes else {
            return
        }
        let indexPaths = (validIndexes.startIndex...validIndexes.endIndex).map { IndexPath(item: $0, section: 0) }
        
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .none)
        tableView.endUpdates()
    }
    
}

extension CarsListViewController: CarsPaginationDelegate {
    
    func carPresenter(_ carPresenter: CarListPresenter, didUpdateFetchState state: FetchState) {
        switch state {
        case .scrolling, .fail:
            activityIndicator.stopAnimating()
            if carPresenter.isLastPage {
                tableView.tableFooterView = nil
            }
        case .fetching:
            self.activityIndicator.startAnimating()
        case .fail(let error):
            print(error)
        }
    }
    
}

extension CarsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.carsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CarInfoTableViewCell.self, forIndexPath: indexPath)
        cell.textLabel?.text = presenter.carName(at: indexPath.row)
        
        return cell
    }
    
}

extension CarsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.attemptFetchNextPage(currentRowIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constant.Segue.showCarDescriptionSegue,
                     sender: presenter.car(at: indexPath.row))
    }
    
}
