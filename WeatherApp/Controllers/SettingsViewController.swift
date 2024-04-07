//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let settingsView: SettingsView = {
        let settingView = SettingsView()
        settingView.translatesAutoresizingMaskIntoConstraints = false
        return settingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        view.backgroundColor = .systemBackground
        
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(settingsView)
        
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
