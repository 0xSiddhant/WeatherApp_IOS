//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import Foundation

final class SettingsViewModel: NSObject {
    enum SettingOption: CaseIterable {
        case upgrade
        case privacyPolicy
        case terms
        case contact
        case getHelp
        case rateApp
        
        var title: String {
            switch self {
            case .upgrade:
                return "Upgrade to Pro"
            case .privacyPolicy:
                return "Privacy Policy"
            case .terms:
                return "Terms of Use"
            case .contact:
                return "Contact Us"
            case .getHelp:
                return "Get Help"
            case .rateApp:
                return "Rate App!"
            }
        }
    }
    
    private var options: [SettingOption]
    
    override init() {
        options = SettingOption.allCases
    }
    
    // MARK: - Setting Options
    private func optionPreConditionCheck(_ index: Int) -> Bool {
        index < 0 || index > (options.count - 1)
    }
    func numberOfOptions() -> Int {
        options.count
    }
    
    func contentOfOptions(at index: Int) -> String? {
        if (optionPreConditionCheck(index)) {
            return nil
        }
        return options[index].title
    }
    
    func optionDidSeleted(at index: IndexPath) {
        if (optionPreConditionCheck(index.row)) {
            return
        }
        print(options[index.row].title)
    }
}
