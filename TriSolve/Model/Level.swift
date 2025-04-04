//
//  Level.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//


struct Level {
    let gridSize: Int
    let tiles: [[TileType]]
    let difficulty: Int
}

let level1 = Level(
    gridSize: 5,
    tiles: [
        [.empty, .empty, .empty, .empty, .empty],
        [.empty, .triangleLeft, .empty, .triangleRight, .empty],
        [.empty, .empty, .start, .empty, .empty],
        [.empty, .empty, .empty, .empty, .empty],
        [.empty, .empty, .empty, .empty, .goal]
    ],
    difficulty: 1
)

let level2 = Level(
    gridSize: 5,
    tiles: [
        [.start, .empty, .triangleRight, .empty, .goal],
        [.empty, .empty, .empty, .triangleLeft, .empty],
        [.empty, .triangleRight, .empty, .empty, .empty],
        [.empty, .empty, .empty, .triangleLeft, .empty],
        [.empty, .empty, .empty, .empty, .empty]
    ],
    difficulty: 1
)

let level3 = Level(
    gridSize: 5,
    tiles: [
        [.empty, .start, .empty, .triangleLeft, .goal],
        [.empty, .empty, .triangleRight, .empty, .empty],
        [.empty, .triangleLeft, .empty, .triangleRight, .empty],
        [.empty, .empty, .empty, .empty, .empty],
        [.empty, .empty, .empty, .empty, .empty]
    ],
    difficulty: 2
)

let level4 = Level(
    gridSize: 5,
    tiles: [
        [.goal, .empty, .empty, .triangleRight, .empty],
        [.empty, .triangleLeft, .empty, .empty, .empty],
        [.empty, .triangleRight, .start, .empty, .empty],
        [.empty, .empty, .empty, .triangleLeft, .empty],
        [.empty, .empty, .empty, .empty, .empty]
    ],
    difficulty: 2
)

let level5 = Level(
    gridSize: 5,
    tiles: [
        [.empty, .empty, .empty, .empty, .goal],
        [.triangleLeft, .empty, .triangleRight, .empty, .empty],
        [.start, .empty, .empty, .empty, .empty],
        [.empty, .empty, .triangleLeft, .empty, .empty],
        [.empty, .empty, .empty, .empty, .empty]
    ],
    difficulty: 2
)

let level6 = Level(
    gridSize: 5,
    tiles: [
        [.empty, .start, .empty, .empty, .empty],
        [.empty, .triangleRight, .empty, .triangleLeft, .empty],
        [.empty, .empty, .empty, .empty, .empty],
        [.empty, .triangleLeft, .empty, .triangleRight, .empty],
        [.empty, .empty, .empty, .empty, .goal]
    ],
    difficulty: 3
)

let level7 = Level(
    gridSize: 5,
    tiles: [
        [.empty, .triangleRight, .start, .empty, .goal],
        [.empty, .empty, .empty, .triangleLeft, .empty],
        [.empty, .triangleRight, .empty, .empty, .empty],
        [.empty, .empty, .empty, .triangleLeft, .empty],
        [.empty, .empty, .empty, .empty, .empty]
    ],
    difficulty: 3
)

let level8 = Level(
    gridSize: 5,
    tiles: [
        [.goal, .empty, .empty, .triangleRight, .empty],
        [.empty, .triangleLeft, .empty, .empty, .empty],
        [.empty, .triangleRight, .start, .empty, .empty],
        [.empty, .empty, .empty, .triangleLeft, .empty],
        [.empty, .empty, .empty, .empty, .empty]
    ],
    difficulty: 3
)

let level9 = Level(
    gridSize: 5,
    tiles: [
        [.start, .empty, .empty, .empty, .goal],
        [.empty, .triangleRight, .empty, .triangleLeft, .empty],
        [.empty, .empty, .empty, .empty, .empty],
        [.empty, .triangleLeft, .empty, .triangleRight, .empty],
        [.empty, .empty, .empty, .empty, .empty]
    ],
    difficulty: 3
)

let level10 = Level(
    gridSize: 5,
    tiles: [
        [.empty, .empty, .start, .empty, .goal],
        [.empty, .triangleRight, .empty, .triangleLeft, .empty],
        [.empty, .empty, .triangleRight, .empty, .empty],
        [.empty, .triangleLeft, .empty, .triangleRight, .empty],
        [.empty, .empty, .empty, .empty, .empty]
    ],
    difficulty: 3
)

let levels: [Level] = [
    level1, level2, level3, level4, level5,
    level6, level7, level8, level9, level10
]

var completedLevels: Set<Int> = [0] // Сохраняй прогресс в UserDefaults, здесь пока тест
