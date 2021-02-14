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
}
