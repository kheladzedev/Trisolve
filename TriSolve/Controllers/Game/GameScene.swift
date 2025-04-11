//
//  GameScene.swift
//  TriSolve
//
//  Created by Edward on 10.04.2025.
//

import SpriteKit

enum Direction {
    case up, down, left, right

    var vector: (row: Int, col: Int) {
        switch self {
        case .up: return (-1, 0)
        case .down: return (1, 0)
        case .left: return (0, -1)
        case .right: return (0, 1)
        }
    }

    func reflected(by tile: TileType) -> Direction {
        switch tile {
        case .triangleLeft:
            switch self {
            case .up: return .left
            case .down: return .right
            case .left: return .up
            case .right: return .down
            }

        case .triangleRight:
            switch self {
            case .up: return .right
            case .down: return .left
            case .left: return .down
            case .right: return .up
            }

        case .triangleRandom:
            return Bool.random() ? self.reflected(by: .triangleLeft) : self.reflected(by: .triangleRight)

        default:
            return self
        }
    }
}

class GameScene: SKScene {

    var level: Level!
    var tileSize: CGFloat = 64
    private var ballNode: SKSpriteNode!
    var ballPosition: (row: Int, col: Int)?
    var onGoalReached: (() -> Void)?

    private var moveHistory: [(Int, Int)] = []

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        removeAllChildren()
        setupLevel()
    }

    func setupLevel() {
        guard level != nil else { return }

        for row in 0..<level.gridSize {
            for col in 0..<level.gridSize {
                let tile = level.tiles[row][col]
                let node = SKSpriteNode(texture: texture(for: tile))
                node.size = CGSize(width: tileSize, height: tileSize)
                node.position = positionFor(row: row, col: col)
                node.zPosition = 0
                addChild(node)

                if tile == .start {
                    ballNode = SKSpriteNode(imageNamed: "ball")
                    ballNode.size = CGSize(width: tileSize * 0.5, height: tileSize * 0.5)
                    ballNode.position = node.position
                    ballNode.zPosition = 1
                    addChild(ballNode)
                    ballPosition = (row, col)
                }

                if tile == .triangleLeft || tile == .triangleRight || tile == .triangleRandom {
                    let glow = SKShapeNode(circleOfRadius: tileSize * 0.3)
                    glow.fillColor = .yellow
                    glow.alpha = 0.3
                    glow.position = .zero
                    glow.zPosition = -1
                    node.addChild(glow)

                    let pulse = SKAction.sequence([
                        SKAction.fadeAlpha(to: 0.6, duration: 0.6),
                        SKAction.fadeAlpha(to: 0.2, duration: 0.6)
                    ])
                    glow.run(SKAction.repeatForever(pulse))
                }
            }
        }
    }

    func moveBall(direction: Direction, completion: ((Bool) -> Void)? = nil) {
        guard var (row, col) = ballPosition else { return }

        var path: [(Int, Int)] = []
        var currentDirection = direction

        while true {
            let vector = currentDirection.vector
            let newRow = row + vector.row
            let newCol = col + vector.col

            guard newRow >= 0, newCol >= 0, newRow < level.gridSize, newCol < level.gridSize else { break }

            let tile = level.tiles[newRow][newCol]
            if tile == .wall { break }

            row = newRow
            col = newCol
            path.append((row, col))

            if tile == .goal { break }

            if tile == .triangleLeft || tile == .triangleRight || tile == .triangleRandom {
                currentDirection = currentDirection.reflected(by: tile)
            }
        }

        guard !path.isEmpty else { return }

        moveHistory.append(ballPosition!)
        ballPosition = (row, col)

        let actions = path.map {
            SKAction.move(to: positionFor(row: $0.0, col: $0.1), duration: 0.1)
        }

        ballNode.run(SKAction.sequence(actions)) { [weak self] in
            guard let self = self else { return }

            if self.level.tiles[row][col] == .goal {
                self.animateVictory()
                self.onGoalReached?()
                completion?(true)
            } else {
                completion?(false)
            }
        }
    }

    func undoLastMove() {
        guard let last = moveHistory.popLast() else { return }

        ballPosition = last
        let position = positionFor(row: last.0, col: last.1)

        let moveBack = SKAction.move(to: position, duration: 0.2)
        ballNode.run(moveBack)
    }

    func showHint() {
        guard let (row, col) = ballPosition else { return }

        let directions: [Direction] = [.up, .down, .left, .right]

        for dir in directions {
            let (dr, dc) = dir.vector
            let newRow = row + dr
            let newCol = col + dc

            guard newRow >= 0, newCol >= 0,
                  newRow < level.gridSize, newCol < level.gridSize else { continue }

            let tile = level.tiles[newRow][newCol]
            if tile != .wall {
                let hint = SKShapeNode(circleOfRadius: tileSize * 0.2)
                hint.fillColor = .cyan
                hint.alpha = 0.0
                hint.position = positionFor(row: newRow, col: newCol)
                hint.zPosition = 5
                addChild(hint)

                hint.run(SKAction.sequence([
                    SKAction.fadeIn(withDuration: 0.3),
                    SKAction.wait(forDuration: 1.0),
                    SKAction.fadeOut(withDuration: 0.3),
                    SKAction.removeFromParent()
                ]))
                break
            }
        }
    }

    private func animateVictory() {
        let scaleUp = SKAction.scale(to: 1.4, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.2)
        let pulse = SKAction.sequence([scaleUp, scaleDown])
        ballNode.run(SKAction.repeat(pulse, count: 3))

        if let emitter = SKEmitterNode(fileNamed: "VictoryParticles.sks") {
            emitter.position = ballNode.position
            emitter.zPosition = 2
            addChild(emitter)

            emitter.run(SKAction.sequence([
                SKAction.wait(forDuration: 2),
                SKAction.removeFromParent()
            ]))
        }
    }

    private func texture(for tile: TileType) -> SKTexture? {
        switch tile {
        case .empty: return SKTexture(imageNamed: "tile_empty")
        case .wall: return SKTexture(imageNamed: "tile_wall")
        case .goal: return SKTexture(imageNamed: "tile_goal")
        case .start: return SKTexture(imageNamed: "tile_start")
        case .triangleLeft: return SKTexture(imageNamed: "tile_triangle_left")
        case .triangleRight: return SKTexture(imageNamed: "tile_triangle_right")
        case .triangleRandom:
            return Bool.random()
                ? SKTexture(imageNamed: "tile_triangle_left")
                : SKTexture(imageNamed: "tile_triangle_right")
        }
    }

    private func positionFor(row: Int, col: Int) -> CGPoint {
        let x = CGFloat(col - row) * tileSize / 2
        let y = CGFloat(col + row) * tileSize / 4
        return CGPoint(x: size.width / 2 + x, y: size.height / 2 + y)
    }
}
