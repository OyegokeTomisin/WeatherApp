//
//  WeatherResultViewController.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import UIKit
import CoreLocation

final class WeatherResultViewController: UIViewController {

    @IBOutlet weak private var resultTableView: UITableView!

    private let viewModel = WeatherResultViewModel()
    private var locationService: LocationService?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewOnLoad()
    }

    private func setupViewOnLoad() {
        setupTableView()
        setupLocationService()
    }

    private func setupTableView() {
        let nib = UINib(nibName: WeatherResultTableViewCell.viewIdentifier, bundle: nil)
        resultTableView.register(nib, forCellReuseIdentifier: WeatherResultTableViewCell.viewIdentifier)
        resultTableView.tableFooterView = UIView()
        resultTableView.contentInsetAdjustmentBehavior = .never
        styleTableBackground()
    }

    private func setupLocationService() {
        locationService = LocationService()
        locationService?.requestLocationServices()
        locationService?.notifyError = { message in
            debugPrint(message)
        }
        locationService?.notifyUserLocation = { [weak viewModel] location in
            viewModel?.requestWeatherData(with: location)
        }
    }

    private func styleTableBackground() {
        resultTableView.backgroundColor = viewModel.weather.colour
    }
}

extension WeatherResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecastCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherResultTableViewCell.viewIdentifier) as? WeatherResultTableViewCell else { return UITableViewCell() }
        cell.configureView(with: viewModel.weatherForecast_toViewModel())
        return cell
    }
}

extension WeatherResultViewController: UITableViewDelegate {

    var sectionHeaderHeight: CGFloat { return 460.0 }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = WeatherResultHeaderView()
        view.configureView(with: viewModel.currentWeather_toViewModel())
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
}
