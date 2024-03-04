//
//  ViewController.swift
//  Vero_ios_task
//
//  Created by ertugrul on 4.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var tasks = [Task]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            loadTasks()
        }
        
        func loadTasks() {
            if let savedTasks = UserDataManager.shared.loadTasks() {
                tasks = savedTasks
                displayTasks()
            } else {
                login()
            }
        }
        
        func login() {
            NetworkManager.shared.login(username: "365", password: "1") { result in
                switch result {
                case .success(let token):
                    print("Access Token: \(token)")
                    self.fetchTasks(token: token)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        
        func fetchTasks(token: String) {
            NetworkManager.shared.fetchTasks(accessToken: token) { result in
                switch result {
                case .success(let fetchedTasks):
                    self.tasks = fetchedTasks
                    UserDataManager.shared.saveTasks(self.tasks)
                    self.displayTasks()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        
        func displayTasks() {
            DispatchQueue.main.async {
                // Use the tasks as needed
                for task in self.tasks {
                    print("Task: \(task.task), Title: \(task.title), Description: \(task.description), Color Code: \(task.colorCode)")
                }
            }
        }

    }
