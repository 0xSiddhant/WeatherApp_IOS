//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import UIKit

protocol CurrentWeatherViewDataSource: AnyObject {
    func numberOfSection() -> Int
    func numberOfItem(in section: Int) -> Int
    func content(of indexPath: IndexPath) -> CurrentWeatherModelProtocol?
}

protocol CurrentWeatherModelProtocol { }

final class CurrentWeatherView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            self?.generateCollectionLayout(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CurrentWeatherCollectionViewCell.self,
                                forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier)
        collectionView.register(HourlyWeatherCollectionViewCell.self,
                                forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier)
        collectionView.register(DailyWeatherCollectionViewCell.self,
                                forCellWithReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier)
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    weak var dataSource: CurrentWeatherViewDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Creation from XIB not allowed")
    }
    
    private func setup() {
        backgroundColor = .systemYellow
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func generateCollectionLayout(for section: Int) -> NSCollectionLayoutSection {
        let section = WeatherViewModel.CurrentWeatherSection.allCases[section]
        
        switch section {
        case .current:
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            ))
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.75)),
                subitems: [item]
            )
            
            return NSCollectionLayoutSection(group: group)
        case .hourly:
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            ))
            
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(0.25),
                                  heightDimension: .absolute(150)),
                subitems: [item]
            )
            group.contentInsets = .init(top: 1, leading: 4, bottom: 1, trailing: 4)
            
            let section =  NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 4)
            return section
        case .daily:
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            ))
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                  heightDimension: .absolute(100)),
                subitems: [item]
            )
            group.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            return NSCollectionLayoutSection(group: group)
        }
    }
    
    func reload() {
        collectionView.reloadData()
    }
}

// MARK: - CollectionView Methods
extension CurrentWeatherView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource?.numberOfSection() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource?.numberOfItem(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let content = dataSource?.content(of: indexPath) else { fatalError() }
        if let model = content as? CurrentWeatherCollectionViewCell.ViewModel,
           let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier,
            for: indexPath
           ) as? CurrentWeatherCollectionViewCell {
            cell.configure(with: model)
            return cell
        } else if let model = content as? DailyWeatherCollectionViewCell.ViewModel,
                  let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier,
                    for: indexPath
                  ) as? DailyWeatherCollectionViewCell {
            cell.configure(with: model)
            return cell
        } else if let model = content as? HourlyWeatherCollectionViewCell.ViewModel,
                  let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier,
                    for: indexPath
                  ) as? HourlyWeatherCollectionViewCell {
            cell.configure(with: model)
            return cell
        }
        fatalError()
    }
}
