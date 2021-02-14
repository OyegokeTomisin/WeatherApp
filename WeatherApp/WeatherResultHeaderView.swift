//
//  WeatherResultHeaderView.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import UIKit

final class WeatherResultHeaderView: UIView {
    
    @IBOutlet private var contentView: UIView!

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
