//
//  MainMenuViewController.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//

import UIKit

class MainMenuViewController: UIViewController {

    // MARK: - UI Elements

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Background"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let logoGameImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo") ?? UIImage(systemName: "photo"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowRadius = 8
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

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Начать игру", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 26) ?? UIFont.boldSystemFont(ofSize: 26)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "Buttons"), for: .normal)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()

    private let levelSelectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбор уровня", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 26) ?? UIFont.boldSystemFont(ofSize: 26)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "Buttons"), for: .normal)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openLevelSelect), for: .touchUpInside)
        return button
    }()

    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Настройки", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 26) ?? UIFont.boldSystemFont(ofSize: 26)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "Buttons"), for: .normal)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        return button
    }()

    private let statsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Статистика", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 26) ?? UIFont.boldSystemFont(ofSize: 26)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "Buttons"), for: .normal)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openStats), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
        animateElements()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Setup UI

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
        view.addSubview(logoGameImageView)
        view.addSubview(startButton)
        view.addSubview(levelSelectButton)
        view.addSubview(settingsButton)
        view.addSubview(statsButton)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),

            logoGameImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoGameImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            logoGameImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            logoGameImageView.heightAnchor.constraint(equalToConstant: 300),

            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: logoGameImageView.bottomAnchor, constant: 20),
            startButton.widthAnchor.constraint(equalToConstant: 320),
            startButton.heightAnchor.constraint(equalToConstant: 80),

            levelSelectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            levelSelectButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20),
            levelSelectButton.widthAnchor.constraint(equalToConstant: 320),
            levelSelectButton.heightAnchor.constraint(equalToConstant: 80),

            settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsButton.topAnchor.constraint(equalTo: levelSelectButton.bottomAnchor, constant: 20),
            settingsButton.widthAnchor.constraint(equalToConstant: 320),
            settingsButton.heightAnchor.constraint(equalToConstant: 80),

            statsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsButton.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 20),
            statsButton.widthAnchor.constraint(equalToConstant: 320),
            statsButton.heightAnchor.constraint(equalToConstant: 80),


        ])
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

    @objc private func openStats() {
        let statsVC = StatsViewController()
        navigationController?.pushViewController(statsVC, animated: false)
    }

    @objc private func openRules() {
        let rulesVC = RulesViewController()
        navigationController?.pushViewController(rulesVC, animated: false)
    }


    // MARK: - Animations

    private func animateElements() {
        let elements = [titleLabel, logoGameImageView, startButton, levelSelectButton, settingsButton, statsButton, ]
        for (index, element) in elements.enumerated() {
            element.alpha = 0
            element.transform = CGAffineTransform(translationX: 0, y: 20).scaledBy(x: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.6,
                           delay: 0.1 * Double(index),
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0.7,
                           options: .curveEaseOut,
                           animations: {
                element.alpha = 1
                element.transform = .identity
            })
        }
    }
}
