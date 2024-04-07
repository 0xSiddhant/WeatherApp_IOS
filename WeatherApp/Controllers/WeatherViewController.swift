//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    let weatherView: CurrentWeatherView = {
        let weatherView = CurrentWeatherView()
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        return weatherView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        view.backgroundColor = .systemBackground
        setUpView()
        setUpLocation()
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
            WeatherManager.shared.getWeather(for: loc)
        }
    }
}

