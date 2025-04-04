//
//  StatsViewController.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//

import UIKit

class StatsViewController: UIViewController {

    private let customNavBar = CustomNavigationBar(title: "Statistics")  // Кастомный навигейшн бар
    private let statsLabel = UILabel()
    private let movesCountLabel = UILabel()
    private let completedLevelsLabel = UILabel()
    private let resetButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange

        // Скрыть стандартный навигейшн бар
        navigationController?.setNavigationBarHidden(true, animated: false)

        // Загружаем статистику из UserDefaults
        loadStats()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func setupUI() {
        // Добавляем кастомный навигейшн бар
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        customNavBar.setBackButtonAction(target: self, action: #selector(backTapped))
        view.addSubview(customNavBar)

        // Статистика
        statsLabel.text = "Game Statistics"
        statsLabel.font = UIFont.boldSystemFont(ofSize: 30)
        statsLabel.textColor = .white
        statsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statsLabel)

        // Количество сделанных ходов
        movesCountLabel.font = UIFont.systemFont(ofSize: 20)
        movesCountLabel.textColor = .white
        movesCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movesCountLabel)

        // Количество пройденных уровней
        completedLevelsLabel.font = UIFont.systemFont(ofSize: 20)
        completedLevelsLabel.textColor = .white
        completedLevelsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(completedLevelsLabel)

        // Кнопка сброса статистики
        resetButton.setTitle("Reset Stats", for: .normal)
        resetButton.addTarget(self, action: #selector(resetStats), for: .touchUpInside)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resetButton)

        // Настройка ограничений
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 60),

            statsLabel.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 20),
            statsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            movesCountLabel.topAnchor.constraint(equalTo: statsLabel.bottomAnchor, constant: 20),
            movesCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            completedLevelsLabel.topAnchor.constraint(equalTo: movesCountLabel.bottomAnchor, constant: 20),
            completedLevelsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            resetButton.topAnchor.constraint(equalTo: completedLevelsLabel.bottomAnchor, constant: 40),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func loadStats() {
        // Загружаем данные из UserDefaults
        let movesCount = UserDefaults.standard.integer(forKey: "movesCount")
        let completedLevels = UserDefaults.standard.integer(forKey: "completedLevels")

        // Обновляем UI
        movesCountLabel.text = "Moves Made: \(movesCount)"
        completedLevelsLabel.text = "Completed Levels: \(completedLevels)"
    }

    @objc private func resetStats() {
        // Сброс статистики в UserDefaults
        UserDefaults.standard.set(0, forKey: "movesCount")
        UserDefaults.standard.set(0, forKey: "completedLevels")

        // Обновляем UI
        loadStats()
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
