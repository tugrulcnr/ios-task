//
//  NetworkManager.swift
//  Vero_ios_task
//
//  Created by ertugrul on 4.03.2024.
//

import Foundation

// https://api.baubuddy.de/index.php/login
// https://api.baubuddy.de/dev/index.php/v1/tasks/select

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL       = "https://api.baubuddy.de/"
    
    private init() {}
    
    
    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
            let headers = [
                "Authorization": "Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz",
                "Content-Type": "application/json"
            ]
            let parameters = [
                "username": username,
                "password": password
            ] as [String : Any]

            do {
                let postData = try JSONSerialization.data(withJSONObject: parameters)
                var request = URLRequest(url: URL(string: "\(baseURL)index.php/login")!)
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headers
                request.httpBody = postData

                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        completion(.failure(error!))
                        return
                    }

                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        guard let accessToken = jsonResponse?["oauth"] as? [String: Any], let token = accessToken["access_token"] as? String else {
                            completion(.failure(NetworkError.invalidResponse))
                            return
                        }
                        completion(.success(token))
                    } catch {
                        completion(.failure(error))
                    }
                }
                task.resume()
            } catch {
                completion(.failure(error))
            }
        }
    
    
    func fetchTasks(accessToken: String, completion: @escaping (Result<[Task], Error>) -> Void) {
        
        var tasks   = [Task]()
        let headers = [
            "Authorization": "Bearer \(accessToken)"
        ]

        var request = URLRequest(url: URL(string: "\(baseURL)dev/index.php/v1/tasks/select")!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                tasks = try JSONDecoder().decode([Task].self, from: data)
                completion(.success(tasks))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
}

enum NetworkError: Error {
    case invalidResponse
}
