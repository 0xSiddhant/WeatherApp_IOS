//
//  DailyWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import UIKit

final class DailyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = DailyWeatherCollectionViewCell.description()
    
    struct ViewModel: CurrentWeatherModelProtocol {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .darkGray
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
