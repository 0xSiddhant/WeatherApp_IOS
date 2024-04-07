//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import CoreLocation
import Foundation
import WeatherKit

final class WeatherManager {
    static let shared = WeatherManager()
    
    private init() { }
    
    func getWeather(for location: CLLocation, _ completion: @escaping (() -> Void)) {
        Task {
            do {
                let weather = try await WeatherService.shared.weather(for: location)
                
                print("Current Weather: ", weather.currentWeather)
                print("Daily Forecast: ", weather.dailyForecast)
                print("Hourly Forecast: ", weather.hourlyForecast)
                print("Minute Forecast: ", weather.minuteForecast ?? "NOT AVAILABLE")
                print("Weather Alerts: ", weather.weatherAlerts ?? "")
                
            } catch {
                print("Error: ", error)
            }
        }
    }
}
