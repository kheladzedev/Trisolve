//
//  MainMenuViewController.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background4"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.textColor = UIColor.systemYellow
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.9
        label.layer.shadowOffset = CGSize(width: 0, height: 3)
        label.layer.shadowRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startButton = MainMenuViewController.makeMenuButton(named: "start", action: #selector(startGame))
    private let levelSelectButton = MainMenuViewController.makeMenuButton(named: "levelselect", action: #selector(openLevelSelect))
    private let settingsButton = MainMenuViewController.makeMenuButton(named: "settings", action: #selector(openSettings))
    
    private let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "info.circle.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openRules), for: .touchUpInside)
        return button
    }()
    
    private let statsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chart.bar.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openStatistics), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupBackground() {
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(startButton)
        view.addSubview(levelSelectButton)
        view.addSubview(settingsButton)
        view.addSubview(infoButton)
        view.addSubview(statsButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 70),
            startButton.widthAnchor.constraint(equalToConstant: 280),
            startButton.heightAnchor.constraint(equalToConstant: 200),
            
            levelSelectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            levelSelectButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 10),
            levelSelectButton.widthAnchor.constraint(equalToConstant: 280),
            levelSelectButton.heightAnchor.constraint(equalToConstant: 200),
            
            settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsButton.topAnchor.constraint(equalTo: levelSelectButton.bottomAnchor, constant: 10),
            settingsButton.widthAnchor.constraint(equalToConstant: 280),
            settingsButton.heightAnchor.constraint(equalToConstant: 200),
            
            infoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoButton.widthAnchor.constraint(equalToConstant: 40),
            infoButton.heightAnchor.constraint(equalToConstant: 40),
            
            statsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            statsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statsButton.widthAnchor.constraint(equalToConstant: 40),
            statsButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private static func makeMenuButton(named imageName: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: imageName), for: .normal)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: action, for: .touchUpInside)
        return button
    }
    
    // MARK: - Actions
    
    @objc private func startGame() {
        let gameVC = GameViewController()
        navigationController?.pushViewController(gameVC, animated: false)
    }
    
    @objc private func openLevelSelect() {
        let levelVC = LevelSelectViewController()
        navigationController?.pushViewController(levelVC, animated: false)
    }
    
    @objc private func openSettings() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: false)
    }
    
    @objc private func openRules() {
        let rulesVC = RulesViewController()
        navigationController?.pushViewController(rulesVC, animated: false)
    }
    
    @objc private func openStatistics() {
        let statsVC = StatisticsViewController()
        navigationController?.pushViewController(statsVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startWiggleAnimation(for: startButton)
        startWiggleAnimation(for: levelSelectButton, delay: 0.2)
        startWiggleAnimation(for: settingsButton, delay: 0.4)
    }
    
    private func startWiggleAnimation(for button: UIView, delay: TimeInterval = 0) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.values = [0, -4, 0, 4, 0]
        animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        animation.duration = 2.0
        animation.repeatCount = .infinity
        animation.beginTime = CACurrentMediaTime() + delay
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        button.layer.add(animation, forKey: "wiggle")
    }
}
