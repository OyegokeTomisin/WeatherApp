//
//  WeatherResultViewController.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import UIKit

final class WeatherResultViewController: UIViewController {

    @IBOutlet weak private var resultTableView: UITableView!

    private let viewModel = WeatherResultViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewOnLoad()
    }

    private func setupViewOnLoad() {
        let nib = UINib(nibName: WeatherResultTableViewCell.viewIdentifier, bundle: nil)
        resultTableView.register(nib, forCellReuseIdentifier: WeatherResultTableViewCell.viewIdentifier)
        resultTableView.tableFooterView = UIView()
        resultTableView.contentInsetAdjustmentBehavior = .never
    }
}

extension WeatherResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherResultTableViewCell.viewIdentifier) as? WeatherResultTableViewCell else { return UITableViewCell() }
        return cell
    }
}

extension WeatherResultViewController: UITableViewDelegate {

    var sectionHeaderHeight: CGFloat { return 450.0 }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = WeatherResultHeaderView()
        view.configureView(with: viewModel.currentWeather_toViewModel())
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
}
