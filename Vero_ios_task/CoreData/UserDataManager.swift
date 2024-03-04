//
//  UserDataManager.swift
//  Vero_ios_task
//
//  Created by ertugrul on 4.03.2024.
//

import Foundation

class UserDataManager {
    static let shared = UserDataManager()
    
    private let userDefaults = UserDefaults.standard
    
    func saveTasks(_ tasks: [Task]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tasks) {
            userDefaults.set(encoded, forKey: UserDefaultsKey.tasks.rawValue)
        }
    }
    
    func loadTasks() -> [Task]? {
        guard let savedTasksData = userDefaults.data(forKey: UserDefaultsKey.tasks.rawValue) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([Task].self, from: savedTasksData)
    }
}
