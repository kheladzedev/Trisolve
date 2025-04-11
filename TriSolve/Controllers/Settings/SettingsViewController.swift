//
//  SettingsViewController.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//

import UIKit

class SettingsViewController: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background3"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let customNavBar = CustomNavigationBar(title: "Settings")
    private let historyButton = UIButton()
    private let searchButton = UIButton()
    private let musicLabel = UILabel()
    private let songLabel = UILabel()
    private let musicSwitch = UISwitch()
    private let songSwitch = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)

        // Добавляем фон
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Кастомный navigation bar
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
        let labelFont = UIFont(name: "Copperplate", size: 22) ?? UIFont.boldSystemFont(ofSize: 22)
        [musicLabel, songLabel].forEach {
            $0.textColor = .white
            $0.font = labelFont
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 1, height: 1)
            $0.layer.shadowRadius = 2
            $0.layer.shadowOpacity = 0.9
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
        navigationController?.popViewController(animated: false)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
