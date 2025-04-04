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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 25) ?? UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.9
        label.layer.shadowOffset = CGSize(width: 0, height: 3)
        label.layer.shadowRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(white: 0.2, alpha: 0.6)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(titleLabel)
        addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setBackButtonAction(target: Any?, action: Selector) {
        backButton.addTarget(target, action: action, for: .touchUpInside)
    }
} 
