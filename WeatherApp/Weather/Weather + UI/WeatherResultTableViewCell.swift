//
//  WeatherResultTableViewCell.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import UIKit

final class WeatherResultTableViewCell: UITableViewCell {

    @IBOutlet weak private var dayLabel: UILabel!
    @IBOutlet weak private var weatherIcon: UIImageView!
    @IBOutlet weak private var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureView(with viewModel: WeatherForecastViewModel) {
        dayLabel.text = viewModel.day
        temperatureLabel.text = viewModel.temprature
        weatherIcon.image = viewModel.weather.image
        contentView.backgroundColor = viewModel.weather.colour
    }
}
