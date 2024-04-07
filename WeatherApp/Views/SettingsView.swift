//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Siddhant Kumar on 07/04/24.
//

import UIKit

protocol SettingsViewDataSource: NSObject {
    func numberOfRows() -> Int
    func content(of indexPath: IndexPath) -> String?
}

protocol SettingsViewDelegate: NSObject {
    func didTapOptin(_ view: UIView, at indexPath: IndexPath)
}

final class SettingsView: UIView {
    private let kCellIDENTIFIER = SettingsView.description()
    lazy var tableView: UITableView = {
       let tV = UITableView()
        tV.register(UITableViewCell.self, forCellReuseIdentifier: kCellIDENTIFIER)
        tV.translatesAutoresizingMaskIntoConstraints = false
        tV.dataSource = self
        tV.delegate = self
        return tV
    }()
    
    weak var dataSource: SettingsViewDataSource?
    weak var delegate: SettingsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("Creation from XIB not allowed")
    }
    
    private func setupView() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - TableView Methods
extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIDENTIFIER, for: indexPath)
        cell.textLabel?.text = dataSource?.content(of: indexPath)
        return cell
    }
}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapOptin(self, at: indexPath)
    }
}
