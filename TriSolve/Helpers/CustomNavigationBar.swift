//
//  CustomNavigationBar.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//

import UIKit

class CustomNavigationBar: UIView {

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "navbar_background")) // 🔥 добавь красивый ассет
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 26) ?? UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .yellow
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        // Эффект свечения
        label.layer.shadowColor = UIColor.orange.cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 8
        return label
    }()

    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left.circle.fill"), for: .normal)
        button.tintColor = UIColor(red: 1, green: 0.8, blue: 0.3, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false

        // Обводка и тень
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.6
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 5
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    convenience init(title: String) {
        self.init(frame: .zero)
        self.title = title
    }

    private func setupView() {
        backgroundColor = .clear
        addSubview(backgroundImageView)
        addSubview(titleLabel)
        addSubview(backButton)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 80),
            backButton.heightAnchor.constraint(equalToConstant: 80),

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setBackButtonAction(target: Any?, action: Selector) {
        backButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
