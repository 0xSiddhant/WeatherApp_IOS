//
//  TabbarViewController.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import UIKit

final class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rootVC1 = UINavigationController(rootViewController: WeatherViewController())
        rootVC1.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "smoke.circle"), selectedImage: UIImage(named: "smoke.circle.fill"))
        
        let rootVC2 = UINavigationController(rootViewController: SettingsViewController())
        rootVC2.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear.circle"), selectedImage: UIImage(systemName: "gear.circle.fill"))
        
        
        setViewControllers([
            rootVC1,
            rootVC2
        ], animated: true)
    }
}
