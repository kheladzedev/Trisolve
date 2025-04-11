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

let level11 = Level(
    gridSize: 5,
    tiles: [
        [.start, .triangleLeft, .triangleLeft, .empty, .triangleLeft],
        [.triangleRight, .triangleLeft, .triangleLeft, .triangleRandom, .empty],
        [.triangleLeft, .triangleRight, .triangleRandom, .empty, .triangleLeft],
        [.empty, .triangleLeft, .triangleRight, .triangleLeft, .goal],
        [.empty, .empty, .triangleRight, .triangleLeft, .empty]
    ],
    difficulty: 3
)

let level12 = Level(
    gridSize: 5,
    tiles: [
        [.triangleRight, .triangleLeft, .triangleRandom, .triangleLeft, .triangleRandom],
        [.triangleLeft, .triangleRight, .triangleRight, .triangleLeft, .empty],
        [.triangleLeft, .triangleRandom, .triangleRandom, .triangleRight, .empty],
        [.triangleRight, .triangleLeft, .triangleLeft, .triangleRight, .triangleRandom],
        [.triangleLeft, .triangleRight, .triangleRight, .triangleRandom, .triangleRandom]
    ],
    difficulty: 3
)

let level13 = Level(
    gridSize: 5,
    tiles: [
        [.triangleRandom, .empty, .triangleRandom, .start, .triangleRandom],
        [.triangleRandom, .triangleRight, .triangleLeft, .triangleRight, .empty],
        [.triangleRight, .empty, .triangleRandom, .triangleRight, .empty],
        [.triangleRight, .empty, .triangleLeft, .triangleRight, .goal],
        [.triangleLeft, .triangleRandom, .triangleRandom, .empty, .triangleRight]
    ],
    difficulty: 3
)

let level14 = Level(
    gridSize: 5,
    tiles: [
        [.triangleLeft, .triangleRight, .triangleRight, .triangleLeft, .triangleRandom],
        [.triangleRight, .triangleRandom, .empty, .triangleRandom, .triangleRandom],
        [.triangleRight, .triangleLeft, .empty, .triangleRight, .triangleRandom],
        [.triangleLeft, .empty, .triangleRandom, .triangleRandom, .triangleRandom],
        [.triangleRandom, .goal, .triangleRight, .triangleRandom, .start]
    ],
    difficulty: 3
)

let level15 = Level(
    gridSize: 5,
    tiles: [
        [.triangleRight, .triangleRight, .triangleLeft, .triangleLeft, .triangleRight],
        [.triangleRight, .empty, .triangleRandom, .triangleRandom, .triangleRandom],
        [.triangleRandom, .goal, .triangleLeft, .triangleLeft, .empty],
        [.start, .empty, .triangleRandom, .triangleLeft, .triangleRight],
        [.triangleRight, .triangleLeft, .triangleRandom, .triangleRandom, .triangleLeft]
    ],
    difficulty: 3
)

let level16 = Level(
    gridSize: 5,
    tiles: [
        [.triangleLeft, .triangleRandom, .triangleLeft, .goal, .triangleLeft],
        [.empty, .triangleRight, .triangleLeft, .empty, .triangleRight],
        [.empty, .triangleRandom, .triangleLeft, .triangleLeft, .triangleRight],
        [.empty, .triangleLeft, .empty, .triangleRight, .triangleLeft],
        [.triangleRight, .triangleLeft, .triangleRandom, .empty, .triangleLeft]
    ],
    difficulty: 3
)

let level17 = Level(
    gridSize: 5,
    tiles: [
        [.empty, .triangleRight, .start, .triangleRandom, .triangleRight],
        [.triangleRight, .empty, .triangleRight, .empty, .empty],
        [.goal, .triangleLeft, .triangleRandom, .empty, .triangleRight],
        [.triangleLeft, .triangleRight, .empty, .triangleLeft, .triangleRandom],
        [.triangleRandom, .triangleLeft, .empty, .triangleRandom, .triangleRandom]
    ],
    difficulty: 3
)

let level18 = Level(
    gridSize: 5,
    tiles: [
        [.triangleRandom, .start, .triangleRandom, .triangleLeft, .triangleRandom],
        [.empty, .triangleRandom, .triangleLeft, .triangleLeft, .triangleRight],
        [.empty, .empty, .empty, .triangleRandom, .triangleRight],
        [.triangleRandom, .triangleRight, .triangleLeft, .triangleLeft, .triangleRight],
        [.triangleRandom, .triangleRight, .triangleRight, .goal, .triangleRandom]
    ],
    difficulty: 3
)

let level19 = Level(
    gridSize: 5,
    tiles: [
        [.triangleLeft, .triangleLeft, .triangleLeft, .triangleLeft, .triangleLeft],
        [.triangleRandom, .triangleRight, .triangleLeft, .triangleRight, .empty],
        [.empty, .triangleLeft, .triangleLeft, .triangleRight, .triangleRandom],
        [.empty, .triangleRandom, .empty, .empty, .triangleRight],
        [.empty, .triangleRandom, .triangleRight, .goal, .triangleLeft]
    ],
    difficulty: 3
)

let level20 = Level(
    gridSize: 5,
    tiles: [
        [.empty, .triangleLeft, .triangleRight, .triangleRandom, .triangleLeft],
        [.triangleRandom, .goal, .empty, .start, .triangleRandom],
        [.triangleLeft, .triangleLeft, .empty, .triangleRight, .empty],
        [.triangleRandom, .triangleLeft, .empty, .triangleRandom, .triangleRight],
        [.empty, .triangleRight, .triangleLeft, .triangleLeft, .empty]
    ],
    difficulty: 3
)

let levels: [Level] = [
    level1, level2, level3, level4, level5,
    level6, level7, level8, level9, level10
]

var completedLevels: Set<Int> = [0] // Сохраняй прогресс в UserDefaults, здесь пока тест
