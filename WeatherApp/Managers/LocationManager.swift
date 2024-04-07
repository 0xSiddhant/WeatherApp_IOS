//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    typealias LocationCompletion = ((CLLocation) -> Void)
    static let shared = LocationManager()
    
    private let manager: CLLocationManager = {
        let manager =  CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        return manager
    }()
    private var currentLocation: CLLocation? {
        didSet {
            if let loc = currentLocation {
                print("Location fetched: ", loc)
                completionHandler?(loc)
            }
        }
    }
    private var completionHandler: LocationCompletion?
    
    private override init() { 
        super.init()
        manager.delegate = self
    }
    
    public func getCurrentLocation(_ completion: @escaping (LocationCompletion)) {
        completionHandler = completion
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        currentLocation = location
        
        manager.stopUpdatingLocation()
    }
}
