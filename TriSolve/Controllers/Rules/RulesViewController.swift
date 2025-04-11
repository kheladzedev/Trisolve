//
//  RulesViewController.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//

import UIKit

class RulesViewController: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let customNavBar = CustomNavigationBar(title: "Rules")

    private let containerView: UIView = {
        let view = UIView()
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0.6).cgColor,
                           UIColor.black.withAlphaComponent(0.3).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.cornerRadius = 20
        view.layer.insertSublayer(gradient, at: 0)
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1.5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        return view
    }()

    private let textView: UITextView = {
        let textView = UITextView()
        textView.attributedText = RulesViewController.styledText()
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 24, left: 18, bottom: 24, right: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        view.addSubview(backgroundImageView)
        view.addSubview(customNavBar)
        view.addSubview(containerView)
        containerView.addSubview(textView)

        customNavBar.setBackButtonAction(target: self, action: #selector(backTapped))
        customNavBar.translatesAutoresizingMaskIntoConstraints = false

        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let gradient = containerView.layer.sublayers?.first as? CAGradientLayer {
            gradient.frame = containerView.bounds
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 60),

            containerView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            textView.topAnchor.constraint(equalTo: containerView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: false)
    }

    private static func styledText() -> NSAttributedString {
        let text = """
        Welcome to TriSolve!

        Your goal is to guide the ball to the red goal tile using the directional arrows.

        The green tile is your starting point.

        The ball keeps rolling in the selected direction until it hits a wall or a special tile.

        Triangle tiles reflect the ball:
        - Left triangle reflects the ball like a mirror.
        - Right triangle reflects it in the opposite way.
        - Random triangle randomly reflects the ball.

        Think strategically to reach the goal in as few moves as possible!

        Earn up to 3 stars based on your performance.

        Good luck, and enjoy the puzzle!
        """

        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 6
        paragraph.alignment = .left

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Copperplate", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .medium),
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraph
        ]

        return NSAttributedString(string: text, attributes: attributes)
    }
}
