//
//  LevelCell.swift
//  TriSolve
//
//  Created by Edward on 10.04.2025.
//

import UIKit

class LevelCell: UICollectionViewCell {
    private let backgroundContainer = UIView()
    private let backgroundImageView = UIImageView()
    private let numberLabel = UILabel()
    private let numberBackgroundView = UIView()
    private let starsStackView = UIStackView()
    private let lockImageView = UIImageView()
    private let glowView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Тень под всей ячейкой
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.35
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 6
        contentView.layer.masksToBounds = false

        // Glow
        glowView.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
        glowView.layer.cornerRadius = 12
        glowView.layer.shadowColor = UIColor.orange.cgColor
        glowView.layer.shadowRadius = 8
        glowView.layer.shadowOpacity = 0.8
        glowView.layer.shadowOffset = .zero
        glowView.translatesAutoresizingMaskIntoConstraints = false
        glowView.isHidden = true
        contentView.addSubview(glowView)

        NSLayoutConstraint.activate([
            glowView.topAnchor.constraint(equalTo: contentView.topAnchor),
            glowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            glowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            glowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        // Контейнер с фоном
        backgroundContainer.layer.cornerRadius = 12
        backgroundContainer.layer.borderWidth = 1.5
        backgroundContainer.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        backgroundContainer.clipsToBounds = true
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backgroundContainer)

        NSLayoutConstraint.activate([
            backgroundContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        // Фон картинки
        backgroundImageView.image = UIImage(named: "level_tile")
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundContainer.addSubview(backgroundImageView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: backgroundContainer.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor)
        ])

        // Фон для номера
        numberBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        numberBackgroundView.layer.cornerRadius = 8
        numberBackgroundView.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        numberBackgroundView.layer.borderWidth = 1
        numberBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(numberBackgroundView)

        numberLabel.font = UIFont(name: "Copperplate-Bold", size: 22)
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        numberLabel.layer.shadowColor = UIColor.black.cgColor
        numberLabel.layer.shadowOpacity = 0.9
        numberLabel.layer.shadowRadius = 2
        numberLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberBackgroundView.addSubview(numberLabel)

        NSLayoutConstraint.activate([
            numberBackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            numberBackgroundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberBackgroundView.widthAnchor.constraint(greaterThanOrEqualToConstant: 36),
            numberBackgroundView.heightAnchor.constraint(equalToConstant: 36),

            numberLabel.centerXAnchor.constraint(equalTo: numberBackgroundView.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: numberBackgroundView.centerYAnchor)
        ])

        // Звезды
        starsStackView.axis = .horizontal
        starsStackView.spacing = 2
        starsStackView.alignment = .center
        starsStackView.distribution = .fillEqually
        starsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(starsStackView)

        NSLayoutConstraint.activate([
            starsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            starsStackView.topAnchor.constraint(equalTo: numberBackgroundView.bottomAnchor, constant: 6),
            starsStackView.heightAnchor.constraint(equalToConstant: 16)
        ])

        // Замок
        lockImageView.image = UIImage(named: "icon_lock")
        lockImageView.contentMode = .scaleAspectFit
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lockImageView)

        NSLayoutConstraint.activate([
            lockImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lockImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lockImageView.widthAnchor.constraint(equalToConstant: 60),
            lockImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            }
        }
    }

    func configure(with number: Int, difficulty: Int, isLocked: Bool, isActive: Bool = false) {
        numberLabel.text = "\(number)"

        starsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for _ in 0..<difficulty {
            let star = UIImageView(image: UIImage(named: "icon_star"))
            star.contentMode = .scaleAspectFit
            star.widthAnchor.constraint(equalToConstant: 16).isActive = true
            starsStackView.addArrangedSubview(star)
        }

        lockImageView.isHidden = !isLocked
        starsStackView.isHidden = isLocked
        numberBackgroundView.isHidden = isLocked
        contentView.alpha = isLocked ? 0.4 : 1.0
        glowView.isHidden = !isActive

        if !isLocked {
            startWiggleAnimation()
        } else {
            stopWiggleAnimation()
        }
    }

    private func startWiggleAnimation() {
        guard layer.animation(forKey: "wiggle") == nil else { return }

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.values = [0, -2, 0, 2, 0]
        animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        animation.duration = 2.0
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        layer.add(animation, forKey: "wiggle")
    }

    private func stopWiggleAnimation() {
        layer.removeAnimation(forKey: "wiggle")
    }
}
