//
//  WeatherResultViewController.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import UIKit

final class WeatherResultViewController: UIViewController {

    @IBOutlet weak private var resultTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewOnLoad()
    }

    private func setupViewOnLoad() {
        resultTableView.tableFooterView = UIView()
    }
}

extension WeatherResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension WeatherResultViewController: UITableViewDelegate {
    
    var sectionHeaderHeight: CGFloat { return 250.0 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return WeatherResultHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
}
