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
    
    public private(set) var currentWeather: CurrentWeather?
    public private(set) var hourlyWeather: [HourWeather]?
    public private(set) var dailyWeather: [DayWeather]?
    
    static let shared = WeatherManager()
    
    private init() { }
    
    func getWeather(for location: CLLocation, _ completion: @escaping (() -> Void)) {
        Task {
            do {
                let result = try await WeatherService.shared.weather(for: location)
                
                self.currentWeather = result.currentWeather
                self.dailyWeather = result.dailyForecast.forecast
                self.hourlyWeather = result.hourlyForecast.forecast
                
                completion()
            } catch {
                print("Error: ", error)
            }
        }
    }
}
