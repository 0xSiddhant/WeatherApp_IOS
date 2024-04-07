//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import UIKit

final class CurrentWeatherView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Creation from XIB not allowed")
    }
    
    private func setup() {
        backgroundColor = .systemYellow
    }
}
