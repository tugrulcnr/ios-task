//
//  TaskViewModel.swift
//  Vero_ios_task
//
//  Created by ertugrul on 5.03.2024.
//

import Foundation

class TaskViewModel {
    private var tasks = [Task]()
    private var filteredTasks = [Task]()

    var numberOfTasks: Int {
        return filteredTasks.count
    }

    func task(at index: Int) -> Task {
        return filteredTasks[index]
    }

    func loadTasks(completion: @escaping (Result<Void, Error>) -> Void) {
        if let savedTasks = UserDataManager.shared.loadTasks() {
            tasks = savedTasks
            filteredTasks = tasks
            completion(.success(()))
        } else {
            login(completion: completion)
        }
    }

    func login(completion: @escaping (Result<Void, Error>) -> Void) {
        NetworkManager.shared.login(username: "365", password: "1") { result in
            switch result {
            case .success(let token):
                print("Access Token: \(token)")
                self.fetchTasks(token: token, completion: completion)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

    func fetchTasks(token: String, completion: @escaping (Result<Void, Error>) -> Void) {
        NetworkManager.shared.fetchTasks(accessToken: token) { result in
            switch result {
            case .success(let fetchedTasks):
                self.tasks = fetchedTasks
                self.filteredTasks = fetchedTasks
                UserDataManager.shared.saveTasks(self.tasks)
                completion(.success(()))
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

    func filterTasks(with searchText: String) {
        filteredTasks = searchText.isEmpty ? tasks : tasks.filter { task in
            return task.title.localizedCaseInsensitiveContains(searchText) ||
                task.task.localizedCaseInsensitiveContains(searchText) ||
                task.description.localizedCaseInsensitiveContains(searchText) ||
                task.sort.localizedCaseInsensitiveContains(searchText) ||
                task.wageType.localizedCaseInsensitiveContains(searchText) ||
                task.BusinessUnitKey?.localizedCaseInsensitiveContains(searchText) ?? false ||
                task.businessUnit.localizedCaseInsensitiveContains(searchText) ||
                task.parentTaskID?.localizedCaseInsensitiveContains(searchText) ?? false ||
                task.preplanningBoardQuickSelect?.localizedCaseInsensitiveContains(searchText) ?? false ||
                task.workingTime?.localizedCaseInsensitiveContains(searchText) ?? false
        }
    }

}
