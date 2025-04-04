//
//  LevelProgressManager.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//


import Foundation

class LevelProgressManager {

    static let shared = LevelProgressManager()

    private let completedLevelsKey = "completedLevelsKey"
    
    private init() {}

    // Сохраняет завершённые уровни в UserDefaults
    func saveCompletedLevels(_ levels: Set<Int>) {
        let levelsArray = Array(levels)
        UserDefaults.standard.set(levelsArray, forKey: completedLevelsKey)
    }

    // Загружает завершённые уровни из UserDefaults
    func loadCompletedLevels() -> Set<Int> {
        if let levelsArray = UserDefaults.standard.array(forKey: completedLevelsKey) as? [Int] {
            return Set(levelsArray)
        } else {
            return Set<Int>()
        }
    }

    // Добавляет уровень в завершённые
    func markLevelAsCompleted(_ level: Int) {
        var completedLevels = loadCompletedLevels()
        completedLevels.insert(level)
        saveCompletedLevels(completedLevels)
    }

    // Проверяет, пройден ли уровень
    func isLevelCompleted(_ level: Int) -> Bool {
        return loadCompletedLevels().contains(level)
    }
}
