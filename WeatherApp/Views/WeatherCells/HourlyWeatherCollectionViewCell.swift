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
        let iconName: String
        let temperature: String
        let hour: String
    }
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(timeLabel)
        contentView.addSubview(icon)
        contentView.addSubview(tempLabel)
        
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        tempLabel.text = nil
        timeLabel.text = nil
        icon.image = nil
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 40),
            timeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            icon.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            icon.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            icon.heightAnchor.constraint(equalToConstant: 32),
            icon.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            tempLabel.topAnchor.constraint(equalTo: icon.bottomAnchor),
            tempLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(with model: ViewModel) {
        icon.image = UIImage(systemName: model.iconName)
        tempLabel.text = model.temperature
        timeLabel.text = model.hour
    }
}
