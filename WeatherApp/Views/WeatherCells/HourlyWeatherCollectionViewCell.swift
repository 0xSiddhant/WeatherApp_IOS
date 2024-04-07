//
//  HourlyWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import UIKit

final class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = HourlyWeatherCollectionViewCell.description()

    struct ViewModel: CurrentWeatherModelProtocol {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with model: ViewModel) {
        
    }
}
