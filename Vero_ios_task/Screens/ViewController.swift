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
        configureLogin()
    }
    
    
    func configureLogin() {
        NetworkManager.shared.login(username: "365", password: "1") { result in
                    switch result {
                    case .success(let token):
                        print("Access Token: \(token)")
                        self.configureGetTasks(token: token)
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
        }
    }
    
    
    func configureGetTasks(token: String ) {
        NetworkManager.shared.fetchTasks(accessToken: token) { result in
                    switch result {
                    case .success(let fetchedTasks):
                        self.tasks = fetchedTasks
                        DispatchQueue.main.async {
                            for task in self.tasks {
                                print("Task: \(task.task), Title: \(task.title), Description: \(task.description), Color Code: \(task.colorCode)")
                            }
                        }
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
    }

}

