//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private lazy var viewModel: SettingsViewModel = {
       return SettingsViewModel()
    }()
    
    private lazy var settingsView: SettingsView = {
        let settingView = SettingsView()
        settingView.delegate = self
        settingView.dataSource = self
        return settingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBackground
        
        setUpView()
        initializeViewModel()
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
    
    //MARK: - Configuration Methods
    private func initializeViewModel() { }
}

// MARK: - SettingsView Methods
extension SettingsViewController: SettingsViewDataSource {
    func numberOfRows() -> Int {
        viewModel.numberOfOptions()
    }
    
    func content(of indexPath: IndexPath) -> String? {
        viewModel.contentOfOptions(at: indexPath.row)
    }
}

extension SettingsViewController: SettingsViewDelegate {
    func didTapOptin(_ view: UIView, at indexPath: IndexPath) {
        viewModel.optionDidSeleted(at: indexPath)
    }
}
