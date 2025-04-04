//
//  SettingsViewController.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//

import UIKit

class SettingsViewController: UIViewController {

    private let customNavBar = CustomNavigationBar(title: "Settings")
    private let historyButton = UIButton()
    private let searchButton = UIButton()
    private let musicLabel = UILabel()
    private let songLabel = UILabel()
    private let musicSwitch = UISwitch()
    private let songSwitch = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Скрытие стандартного навигейшн бара
        navigationController?.setNavigationBarHidden(true, animated: false)

        view.backgroundColor = UIColor(white: 0.98, alpha: 1)

        // Добавляем кастомный навигейшн бар
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        customNavBar.setBackButtonAction(target: self, action: #selector(backTapped))
        view.addSubview(customNavBar)

        setupUI()
        setupSwitchAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    private func setupUI() {
        // История
        historyButton.setImage(UIImage(named: "icon_history"), for: .normal)
        view.addSubview(historyButton)
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyButton.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 8),
            historyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            historyButton.widthAnchor.constraint(equalToConstant: 50),
            historyButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Поиск
        searchButton.setImage(UIImage(named: "icon_search"), for: .normal)
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.centerYAnchor.constraint(equalTo: historyButton.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchButton.widthAnchor.constraint(equalToConstant: 50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Labels
        musicLabel.text = "Notifications:"
        songLabel.text = "Music:"
        [musicLabel, songLabel].forEach {
            $0.textColor = .orange
            $0.font = .boldSystemFont(ofSize: 22)
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        // Switches
        [musicSwitch, songSwitch].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            musicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            musicLabel.topAnchor.constraint(equalTo: historyButton.bottomAnchor, constant: 80),

            musicSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            musicSwitch.centerYAnchor.constraint(equalTo: musicLabel.centerYAnchor),

            songLabel.leadingAnchor.constraint(equalTo: musicLabel.leadingAnchor),
            songLabel.topAnchor.constraint(equalTo: musicLabel.bottomAnchor, constant: 40),

            songSwitch.trailingAnchor.constraint(equalTo: musicSwitch.trailingAnchor),
            songSwitch.centerYAnchor.constraint(equalTo: songLabel.centerYAnchor)
        ])
    }

    private func setupSwitchAppearance() {
        [musicSwitch, songSwitch].forEach {
            $0.onTintColor = UIColor.yellow
            $0.thumbTintColor = UIColor.orange
            $0.layer.cornerRadius = $0.bounds.height / 2
        }
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // Кастомный навигейшн бар
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
