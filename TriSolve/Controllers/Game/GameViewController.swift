//
//  GameViewController.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//

// Этот файл будет содержать полный код всех экранов поочередно

import UIKit

class GameViewController: UIViewController {

    private let customNavBar = CustomNavigationBar(title: "LEVEL 1")
    private let moveCounterLabel = UILabel()
    private let boardView = UIView()

    private let resetButton = UIButton(type: .system)
    private let undoButton = UIButton(type: .system)
    private let hintButton = UIButton(type: .system)

    private let upButton = UIButton(type: .system)
    private let downButton = UIButton(type: .system)
    private let leftButton = UIButton(type: .system)
    private let rightButton = UIButton(type: .system)

    private var ballView: UIView!
    private var moveCount = 0
    private let maxMoves = 10
    private let movementStep: CGFloat = 40.0

    private var ballCenter: CGPoint = .zero

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImageView = UIImageView(image: UIImage(named: "background2"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        setupUI()
        setupBench()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBench()
    }

    private func setupBench() {
        boardView.subviews.forEach { $0.removeFromSuperview() }

        let benchImageView = UIImageView(image: UIImage(named: "bench"))
        benchImageView.contentMode = .scaleAspectFit
        benchImageView.translatesAutoresizingMaskIntoConstraints = false
        boardView.addSubview(benchImageView)
        boardView.sendSubviewToBack(benchImageView)

        NSLayoutConstraint.activate([
            benchImageView.topAnchor.constraint(equalTo: boardView.topAnchor),
            benchImageView.bottomAnchor.constraint(equalTo: boardView.bottomAnchor),
            benchImageView.leadingAnchor.constraint(equalTo: boardView.leadingAnchor),
            benchImageView.trailingAnchor.constraint(equalTo: boardView.trailingAnchor)
        ])

        placeBallAtBenchCenter()
    }

    private func placeBallAtBenchCenter() {
        ballView?.removeFromSuperview()

        let ballSize = boardView.bounds.width * 0.2 // увеличен в 2 раза
        let imageView = UIImageView(image: UIImage(named: "ballImage"))
        imageView.frame = CGRect(x: 0, y: 0, width: ballSize, height: ballSize)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        imageView.layer.shadowColor = UIColor.white.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 8
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)

        ballView = imageView

        ballCenter = CGPoint(
            x: boardView.bounds.midX,
            y: boardView.bounds.midY - boardView.bounds.height * 0.15 // поднят выше
        )

        ballView.center = ballCenter
        boardView.addSubview(ballView)
    }

    private func setupUI() {
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        customNavBar.setBackButtonAction(target: self, action: #selector(backTapped))
        view.addSubview(customNavBar)

        moveCounterLabel.text = "Moves: 0 / \(maxMoves)"
        moveCounterLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 28, weight: .bold)
        moveCounterLabel.textColor = .white
        moveCounterLabel.layer.shadowColor = UIColor.red.cgColor
        moveCounterLabel.layer.shadowOpacity = 0.9
        moveCounterLabel.layer.shadowRadius = 6
        moveCounterLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        moveCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moveCounterLabel)

        boardView.backgroundColor = .clear
        boardView.layer.cornerRadius = 16
        boardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardView)

        configureTopButtons()
        configureArrowButtons()
        setupConstraints()
    }

    private func configureTopButtons() {
        let topButtons = [(resetButton, "RESET"), (undoButton, "UNDO"), (hintButton, "HINT")]

        for (button, title) in topButtons {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .bold)
            button.backgroundColor = UIColor(red: 0.2, green: 0.05, blue: 0.05, alpha: 0.85)
            button.layer.cornerRadius = 14
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor(red: 1, green: 0.4, blue: 0.2, alpha: 0.3).cgColor
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.8
            button.layer.shadowOffset = CGSize(width: 0, height: 3)
            button.layer.shadowRadius = 6

            let innerGlow = CALayer()
            innerGlow.frame = CGRect(x: 0, y: 0, width: 80, height: 44)
            innerGlow.backgroundColor = UIColor.white.withAlphaComponent(0.05).cgColor
            innerGlow.cornerRadius = 14
            button.layer.insertSublayer(innerGlow, at: 0)

            view.addSubview(button)
        }

        resetButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
    }

    private func configureArrowButtons() {
        let arrowButtons: [(UIButton, CGAffineTransform)] = [
            (upButton, .identity),
            (leftButton, CGAffineTransform(rotationAngle: -.pi / 2)),
            (downButton, CGAffineTransform(rotationAngle: .pi)),
            (rightButton, CGAffineTransform(rotationAngle: .pi / 2))
        ]

        for (button, transform) in arrowButtons {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(red: 0.5, green: 0.1, blue: 0, alpha: 1)
            button.layer.cornerRadius = 16
            button.layer.shadowColor = UIColor.orange.cgColor
            button.layer.shadowOpacity = 0.8
            button.layer.shadowOffset = CGSize(width: 0, height: 4)
            button.layer.shadowRadius = 10

            let arrowLayer = createArrowShapeLayer()
            arrowLayer.setAffineTransform(transform)
            button.layer.addSublayer(arrowLayer)

            view.addSubview(button)
        }

        upButton.addTarget(self, action: #selector(moveUp), for: .touchUpInside)
        downButton.addTarget(self, action: #selector(moveDown), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(moveLeft), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(moveRight), for: .touchUpInside)
    }

    private func createArrowShapeLayer() -> CAShapeLayer {
        let arrowLayer = CAShapeLayer()
        let path = UIBezierPath()
        let size: CGFloat = 24
        let centerX: CGFloat = 32
        let centerY: CGFloat = 32

        path.move(to: CGPoint(x: centerX, y: centerY - size / 2))
        path.addLine(to: CGPoint(x: centerX - size / 2, y: centerY + size / 2))
        path.addLine(to: CGPoint(x: centerX + size / 2, y: centerY + size / 2))
        path.close()

        arrowLayer.path = path.cgPath
        arrowLayer.fillColor = UIColor.yellow.cgColor
        arrowLayer.shadowColor = UIColor.white.cgColor
        arrowLayer.shadowOpacity = 0.8
        arrowLayer.shadowOffset = CGSize(width: 0, height: 2)
        arrowLayer.shadowRadius = 4
        arrowLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)

        return arrowLayer
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 60),

            moveCounterLabel.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 12),
            moveCounterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            boardView.topAnchor.constraint(equalTo: moveCounterLabel.bottomAnchor, constant: 12),
            boardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            boardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor, multiplier: 1.4),

            // Кнопки управления — остаются на месте
            resetButton.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: -76),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            resetButton.widthAnchor.constraint(equalToConstant: 80),
            resetButton.heightAnchor.constraint(equalToConstant: 44),

            undoButton.centerYAnchor.constraint(equalTo: resetButton.centerYAnchor),
            undoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            undoButton.widthAnchor.constraint(equalToConstant: 80),
            undoButton.heightAnchor.constraint(equalToConstant: 44),

            hintButton.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: -76),
            hintButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            hintButton.widthAnchor.constraint(equalToConstant: 80),
            hintButton.heightAnchor.constraint(equalToConstant: 44),

            // Стрелки — опущены ниже
            downButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 88), // было 48 → стало 88
            downButton.widthAnchor.constraint(equalToConstant: 64),
            downButton.heightAnchor.constraint(equalToConstant: 64),

            upButton.centerXAnchor.constraint(equalTo: downButton.centerXAnchor),
            upButton.bottomAnchor.constraint(equalTo: downButton.topAnchor, constant: -16),
            upButton.widthAnchor.constraint(equalToConstant: 64),
            upButton.heightAnchor.constraint(equalToConstant: 64),

            leftButton.centerYAnchor.constraint(equalTo: downButton.centerYAnchor),
            leftButton.trailingAnchor.constraint(equalTo: downButton.leadingAnchor, constant: -16),
            leftButton.widthAnchor.constraint(equalToConstant: 64),
            leftButton.heightAnchor.constraint(equalToConstant: 64),

            rightButton.centerYAnchor.constraint(equalTo: downButton.centerYAnchor),
            rightButton.leadingAnchor.constraint(equalTo: downButton.trailingAnchor, constant: 16),
            rightButton.widthAnchor.constraint(equalToConstant: 64),
            rightButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    private func moveBallBy(delta: CGPoint) {
        guard moveCount < maxMoves, ballView != nil else { return }
        moveCount += 1
        moveCounterLabel.text = "Moves: \(moveCount) / \(maxMoves)"

        ballCenter.x += delta.x
        ballCenter.y += delta.y

        let halfSize = ballView.bounds.width / 2
        ballCenter.x = max(halfSize, min(boardView.bounds.width - halfSize, ballCenter.x))
        ballCenter.y = max(halfSize, min(boardView.bounds.height - halfSize, ballCenter.y))

        UIView.animate(withDuration: 0.2) {
            self.ballView.center = self.ballCenter
        }
    }

    @objc private func moveUp() {
        moveBallBy(delta: CGPoint(x: 0, y: -movementStep))
    }

    @objc private func moveDown() {
        moveBallBy(delta: CGPoint(x: 0, y: movementStep))
    }

    @objc private func moveLeft() {
        moveBallBy(delta: CGPoint(x: -movementStep, y: 0))
    }

    @objc private func moveRight() {
        moveBallBy(delta: CGPoint(x: movementStep, y: 0))
    }

    @objc private func resetGame() {
        moveCount = 0
        moveCounterLabel.text = "Moves: 0 / \(maxMoves)"
        setupBench()
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: false)
    }
}
