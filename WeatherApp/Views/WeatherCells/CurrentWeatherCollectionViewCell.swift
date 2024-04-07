//
//  CurrentWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import UIKit

final class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = CurrentWeatherCollectionViewCell.description()
    
    struct ViewModel: CurrentWeatherModelProtocol {
        let condition: String
        let temperature: String
        let iconName: String
    }
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 62, weight: .medium)
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 34, weight: .regular)
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
        
        contentView.addSubview(tempLabel)
        contentView.addSubview(icon)
        contentView.addSubview(conditionLabel)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        conditionLabel.text = nil
        tempLabel.text = nil
        icon.image = nil
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            tempLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            icon.heightAnchor.constraint(equalToConstant: 55),
            icon.widthAnchor.constraint(equalToConstant: 55),
            icon.topAnchor.constraint(equalTo: tempLabel.bottomAnchor),
            icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            conditionLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 10),
            conditionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor),
            conditionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15),
            conditionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
    
    func configure(with model: ViewModel) {
        icon.image = UIImage(systemName: model.iconName)
        conditionLabel.text = model.condition
        tempLabel.text = model.temperature
    }
}
