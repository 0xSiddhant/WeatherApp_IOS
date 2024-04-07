//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    lazy var viewModel: WeatherViewModel = {
        return WeatherViewModel()
    }()
    
    lazy var weatherView: CurrentWeatherView = {
        let weatherView = CurrentWeatherView()
        weatherView.dataSource = self
        return weatherView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        view.backgroundColor = .systemBackground
        setUpView()
        setUpLocation()
        initializeViewModel()
    }

    private func setUpView() {
        view.addSubview(weatherView)
        
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            weatherView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weatherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setUpLocation() {
        LocationManager.shared.getCurrentLocation { loc in
            WeatherManager.shared.getWeather(for: loc) { [weak self] in
                DispatchQueue.main.async {
                    self?.viewModel.generateWeatherData()
                }
            }
        }
    }
    
    private func initializeViewModel() { 
        viewModel.reloadWeatherDataCallBack = { [weak self] in
            self?.weatherView.reload()
        }
    }
}

// MARK: - Current Weather View Methods
extension WeatherViewController: CurrentWeatherViewDataSource {
    func numberOfSection() -> Int {
        viewModel.numberOfCurrentWeatherSection()
    }
    
    func numberOfItem(in section: Int) -> Int {
        viewModel.numberOfItems(in: section)
    }
    
    func content(of indexPath: IndexPath) -> CurrentWeatherModelProtocol? {
        viewModel.content(of: indexPath)
    }
}
