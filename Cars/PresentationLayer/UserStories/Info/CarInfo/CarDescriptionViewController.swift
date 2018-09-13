//
//  CarDescriptionViewController.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import UIKit

class CarDescriptionViewController: UIViewController, Storyboardable {

    @IBOutlet private weak var tableView: UITableView!
    var presenter: CarDescriptionPresenter!
    
    static var storyboardName: String {
        return Constant.Storyboard.carList.rawValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
    }

}

extension CarDescriptionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.fieldCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let descriptor = presenter.description(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(CarDescriptionTableViewCell.self, forIndexPath: indexPath)
        cell.configure(with: descriptor)
        
        return cell
    }
    
}

extension CarDescriptionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
