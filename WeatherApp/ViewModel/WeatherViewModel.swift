//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import Foundation
import WeatherKit

final class WeatherViewModel {
    enum CurrentWeatherSection: CaseIterable, CustomStringConvertible {
        case current
        case hourly
        case daily
        
        var description: String {
            switch self {
            case .current:
                return "Current"
            case .hourly:
                return "Hourly"
            case .daily:
                return "Daily"
            }
        }
    }
    
    private var weatherSections: [CurrentWeatherSection]
    private var currentWeatherModel: CurrentWeatherCollectionViewCell.ViewModel?
    private var hourlyWeatherModel: [HourlyWeatherCollectionViewCell.ViewModel]?
    private var dailyWeatherModel: [DailyWeatherCollectionViewCell.ViewModel]?
    
    var reloadWeatherDataCallBack: (() -> Void)?
    
    
    init() {
        weatherSections = []
    }
    
    func generateWeatherData() {
        if let currentWeatherData = WeatherManager.shared.currentWeather {
            currentWeatherModel = transformToCurrentWeatherModel(from: currentWeatherData)
            weatherSections.append(.current)
        }
        if let hourlyWeatherData = WeatherManager.shared.hourlyWeather,
           !hourlyWeatherData.isEmpty {
            hourlyWeatherModel = transformToHourlyWeatherModel(from: hourlyWeatherData)
            weatherSections.append(.hourly)
        }
        
        if let dailyWeatherData = WeatherManager.shared.dailyWeather,
           !dailyWeatherData.isEmpty {
            dailyWeatherModel = transformToDailyWeatherModel(from: dailyWeatherData)
            weatherSections.append(.daily)
        }
        reloadWeatherDataCallBack?()
    }
    
    func numberOfCurrentWeatherSection() -> Int {
        weatherSections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        switch weatherSections[section] {
        case .current:
            return 1
        case .hourly:
            return hourlyWeatherModel?.count ?? 0
        case .daily:
            return dailyWeatherModel?.count ?? 0
        }
    }
    
    func content(of indexPath: IndexPath) -> CurrentWeatherModelProtocol? {
        switch weatherSections[indexPath.section] {
        case .current:
            return currentWeatherModel
        case .hourly:
            return hourlyWeatherModel?[indexPath.row]
        case .daily:
            return dailyWeatherModel?[indexPath.row]
        }
    }
}

// MARK: - Transform Methods
private extension WeatherViewModel {
    func transformToCurrentWeatherModel(from model: CurrentWeather) -> CurrentWeatherCollectionViewCell.ViewModel {
        .init(condition: model.condition.description,
              temperature: "\(Int(model.temperature.converted(to: .fahrenheit).value)) °F",
              iconName: model.symbolName)
    }
    
    func transformToHourlyWeatherModel(from model: [HourWeather]) -> [HourlyWeatherCollectionViewCell.ViewModel] {
        model.map { item in .init(
            iconName: item.symbolName,
            temperature: "\(Int(item.temperature.converted(to: .fahrenheit).value)) °F",
            hour: "\(Calendar.current.component(.hour, from: item.date)):00")
        }
    }
    
    func transformToDailyWeatherModel(from model: [DayWeather]) -> [DailyWeatherCollectionViewCell.ViewModel] {
        func string(for temp: Measurement<UnitTemperature>) -> String {
            return "\(Int(temp.converted(to: .fahrenheit).value)) °F"
        }
        
        func string(from day: Int) -> String {
            switch (day) {
            case 1:
                return "Monday"
            case 2:
                return "Tuesday"
            case 3:
                return "Wednesday"
            case 4:
                return "Thursday"
            case 5:
                return "Friday"
            case 6:
                return "Saturday"
            case 7:
                return "Sunday"
            default:
                return "Unavailable"
            }
        }
        
        return model.map { item in .init(
            iconName: item.symbolName,
            temperatureRange: "\(string(for: item.lowTemperature)) ~ \(string(for: item.highTemperature))",
            day: string(from: Calendar.current.component(.weekday, from: item.date)))
        }
    }
}
