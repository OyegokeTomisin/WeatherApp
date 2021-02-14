//
//  WeatherResultHeaderView.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import UIKit

final class WeatherResultHeaderView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var overlay: UIView!
    @IBOutlet weak private var maxLabel: UILabel!
    @IBOutlet weak private var minLabel: UILabel!
    @IBOutlet weak private var currentLabel: UILabel!
    @IBOutlet weak private var currentBigLabel: UILabel!
    @IBOutlet weak private var weatherImageView: UIImageView!
    @IBOutlet weak private var weatherDescriptionLabel: UILabel!

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        loadFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func loadFromNib() {
        Bundle.main.loadNibNamed(WeatherResultHeaderView.viewIdentifier, owner: self, options: nil)
        addSubview(contentView)
    }
}
