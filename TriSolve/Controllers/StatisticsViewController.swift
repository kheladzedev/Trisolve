//
//  StatisticsViewController.swift
//  TriSolve
//
//  Created by Edward on 11.04.2025.
//
import UIKit

class StatisticsViewController: UIViewController {

    private let customNavBar = CustomNavigationBar(title: "STATISTICS")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func setupBackground() {
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupUI() {
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        customNavBar.setBackButtonAction(target: self, action: #selector(backTapped))
        view.addSubview(customNavBar)

        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 60)
        ])

        let stats = [
            ("Levels Completed", "18 / 30"),
            ("Total Moves Made", "742"),
            ("Average Moves per Level", "41.2"),
            ("Hints Used", "6"),
            ("Best Time", "02:03"),
            ("Total Play Time", "01h 12m")
        ]

        var previousCard: UIView? = nil
        for (title, value) in stats {
            let card = createStatCard(title: title, value: value)
            view.addSubview(card)

            NSLayoutConstraint.activate([
                card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                card.heightAnchor.constraint(equalToConstant: 80)
            ])

            if let previous = previousCard {
                card.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 16).isActive = true
            } else {
                card.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 24).isActive = true
            }

            previousCard = card
        }
    }

    private func createStatCard(title: String, value: String) -> UIView {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        card.layer.cornerRadius = 16
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.4
        card.layer.shadowRadius = 6
        card.layer.shadowOffset = CGSize(width: 0, height: 4)

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.alpha = 0.9

        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = value
        valueLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .bold)
        valueLabel.textColor = UIColor.systemYellow
        valueLabel.textAlignment = .right
        valueLabel.layer.shadowColor = UIColor.black.cgColor
        valueLabel.layer.shadowOpacity = 0.6
        valueLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        valueLabel.layer.shadowRadius = 4

        card.addSubview(titleLabel)
        card.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: card.centerYAnchor),

            valueLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            valueLabel.centerYAnchor.constraint(equalTo: card.centerYAnchor)
        ])

        return card
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: false)
    }
}
