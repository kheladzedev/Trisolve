//
//  GameViewController.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//

import UIKit

class GameViewController: UIViewController {

    var currentLevel: Level!
    var currentLevelIndex: Int = 0

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
    private var ballPosition: (row: Int, col: Int)?

    private var moveCount = 0
    private let maxMoves = 10

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        if currentLevel == nil {
            currentLevel = levels[currentLevelIndex]
        }

        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        boardView.subviews.forEach { $0.removeFromSuperview() }
        setupBoardTiles()
    }

    // MARK: - Stars Calculation

    private func calculateStars(for moves: Int) -> Int {
        switch moves {
        case 0...5: return 3
        case 6...10: return 2
        default: return 1
        }
    }
    
    private func setupBoardTiles() {
        guard currentLevel != nil else { return }

        let tileSize: CGFloat = boardView.bounds.width / CGFloat(currentLevel.gridSize)
        for row in 0..<currentLevel.gridSize {
            for col in 0..<currentLevel.gridSize {
                let tile = IsometricTileView(frame: CGRect(x: 0, y: 0, width: tileSize, height: tileSize))

                let xOffset = CGFloat(col - row) * tileSize / 2
                let yOffset = CGFloat(col + row) * tileSize / 4

                tile.center = CGPoint(
                    x: boardView.bounds.midX + xOffset,
                    y: boardView.bounds.midY + yOffset
                )

                tile.type = currentLevel.tiles[row][col]

                boardView.addSubview(tile)
            }
        }

        for row in 0..<currentLevel.gridSize {
            for col in 0..<currentLevel.gridSize {
                if currentLevel.tiles[row][col] == .start {
                    ballPosition = (row, col)
                    placeBall(at: row, col: col, tileSize: tileSize)
                    return
                }
            }
        }
    }

    private func placeBall(at row: Int, col: Int, tileSize: CGFloat) {
        let ballSize = tileSize * 0.4
        ballView = UIView(frame: CGRect(x: 0, y: 0, width: ballSize, height: ballSize))
        ballView.backgroundColor = .cyan
        ballView.layer.cornerRadius = ballSize / 2
        ballView.layer.borderColor = UIColor.white.cgColor
        ballView.layer.borderWidth = 2
        ballView.clipsToBounds = true

        let xOffset = CGFloat(col - row) * tileSize / 2
        let yOffset = CGFloat(col + row) * tileSize / 4
        ballView.center = CGPoint(
            x: boardView.bounds.midX + xOffset,
            y: boardView.bounds.midY + yOffset
        )

        boardView.addSubview(ballView)
        boardView.bringSubviewToFront(ballView)
    }

    private func setupUI() {
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        customNavBar.setBackButtonAction(target: self, action: #selector(backTapped))
        view.addSubview(customNavBar)

        moveCounterLabel.text = "Moves: 0 / 10"
        moveCounterLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        moveCounterLabel.textColor = .white
        moveCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moveCounterLabel)

        boardView.backgroundColor = .darkGray
        boardView.layer.cornerRadius = 16
        boardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardView)

        resetButton.setTitle("⟲", for: .normal)
        undoButton.setTitle("Undo", for: .normal)
        hintButton.setTitle("?", for: .normal)

        resetButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)

        for button in [resetButton, undoButton, hintButton] {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
        }

        let arrowButtons = [upButton, downButton, leftButton, rightButton]
        let symbols = ["↑", "↓", "←", "→"]

        for (button, symbol) in zip(arrowButtons, symbols) {
            button.setTitle(symbol, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .bold)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemOrange
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
        }

        upButton.addTarget(self, action: #selector(moveUp), for: .touchUpInside)
        downButton.addTarget(self, action: #selector(moveDown), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(moveLeft), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(moveRight), for: .touchUpInside)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 60),

            moveCounterLabel.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 12),
            moveCounterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            boardView.topAnchor.constraint(equalTo: moveCounterLabel.bottomAnchor, constant: 20),
            boardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            boardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor),

            resetButton.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 20),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            resetButton.widthAnchor.constraint(equalToConstant: 80),
            resetButton.heightAnchor.constraint(equalToConstant: 44),

            undoButton.centerYAnchor.constraint(equalTo: resetButton.centerYAnchor),
            undoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            undoButton.widthAnchor.constraint(equalToConstant: 80),
            undoButton.heightAnchor.constraint(equalToConstant: 44),

            hintButton.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 20),
            hintButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            hintButton.widthAnchor.constraint(equalToConstant: 80),
            hintButton.heightAnchor.constraint(equalToConstant: 44),

            downButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 80),
            downButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downButton.widthAnchor.constraint(equalToConstant: 60),
            downButton.heightAnchor.constraint(equalToConstant: 60),

            upButton.bottomAnchor.constraint(equalTo: downButton.topAnchor, constant: -16),
            upButton.centerXAnchor.constraint(equalTo: downButton.centerXAnchor),
            upButton.widthAnchor.constraint(equalToConstant: 60),
            upButton.heightAnchor.constraint(equalToConstant: 60),

            leftButton.centerYAnchor.constraint(equalTo: downButton.centerYAnchor),
            leftButton.trailingAnchor.constraint(equalTo: downButton.leadingAnchor, constant: -16),
            leftButton.widthAnchor.constraint(equalToConstant: 60),
            leftButton.heightAnchor.constraint(equalToConstant: 60),

            rightButton.centerYAnchor.constraint(equalTo: downButton.centerYAnchor),
            rightButton.leadingAnchor.constraint(equalTo: downButton.trailingAnchor, constant: 16),
            rightButton.widthAnchor.constraint(equalToConstant: 60),
            rightButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    @objc private func moveUp() {
        moveBall(dRow: -1, dCol: 0)
    }

    @objc private func moveDown() {
        moveBall(dRow: 1, dCol: 0)
    }

    @objc private func moveLeft() {
        moveBall(dRow: 0, dCol: -1)
    }

    @objc private func moveRight() {
        moveBall(dRow: 0, dCol: 1)
    }

    private func moveBall(dRow: Int, dCol: Int) {
        guard moveCount < maxMoves else { return }
        guard let position = ballPosition else { return }

        let newRow = position.row + dRow
        let newCol = position.col + dCol

        guard newRow >= 0, newCol >= 0,
              newRow < currentLevel.gridSize,
              newCol < currentLevel.gridSize else { return }

        ballPosition = (newRow, newCol)
        moveCount += 1
        moveCounterLabel.text = "Moves: \(moveCount) / \(maxMoves)"

        let tileSize = boardView.bounds.width / CGFloat(currentLevel.gridSize)
        let xOffset = CGFloat(newCol - newRow) * tileSize / 2
        let yOffset = CGFloat(newCol + newRow) * tileSize / 4
        let newCenter = CGPoint(
            x: boardView.bounds.midX + xOffset,
            y: boardView.bounds.midY + yOffset
        )

        UIView.animate(withDuration: 0.2) {
            self.ballView.center = newCenter
        }

        let tileType = currentLevel.tiles[newRow][newCol]
        if tileType == .goal {
            showVictoryAlert()
        } else if tileType == .triangleLeft {
            moveBall(dRow: dCol, dCol: -dRow)
        } else if tileType == .triangleRight {
            moveBall(dRow: -dCol, dCol: dRow)
        }
    }

    private func showVictoryAlert() {
        let alert = UIAlertController(
            title: "🎉 Victory!",
            message: "You reached the goal in \(moveCount) moves.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Next Level", style: .default) { _ in
            self.loadNextLevel()
        })
        present(alert, animated: true)
    }

    private func loadNextLevel() {
        if currentLevelIndex + 1 < levels.count {
            // Отметим текущий уровень как завершённый
            LevelProgressManager.shared.markLevelAsCompleted(currentLevelIndex)

            currentLevelIndex += 1
            currentLevel = levels[currentLevelIndex]
            resetGame()
        } else {
            let alert = UIAlertController(title: "🏁 Done!", message: "You've completed all levels!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    

    @objc private func resetGame() {
        moveCount = 0
        moveCounterLabel.text = "Moves: 0 / \(maxMoves)"
        setupBoardTiles()
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
