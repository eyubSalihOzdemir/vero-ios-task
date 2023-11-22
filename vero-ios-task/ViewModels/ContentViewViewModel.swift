//
//  ContentViewViewModel.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 17.11.2023.
//

import Foundation
import CoreData

// error types to make debuggin easier for us
enum DataError: Error {
    case invalidDataAuth
    case invalidResponseAuth
    case typeConversionAuth
    case invalidData
    case invalidResponse
    case typeConversion
    case message(_ error: Error?)
}

@MainActor class ContentViewViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    @Published var loading = false
    @Published var isShowingDrawer: Bool = false
       
    init() {
        // fetch the data as soon as we initialize this class
        //self.fetch()
    }
    
    // function to get the login token
    private func getAuth(completion: @escaping (Result<String, Error>) -> Void) {
        let headers = [
            "Authorization": "Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz",
            "Content-Type": "application/json"
        ]
        let jsonData = [
            "username": "365",
            "password": "1"
        ] as [String : Any]
        
        // we can force unwrap the URL since we know it's a valid, constant link
        let url = URL(string: "https://api.baubuddy.de/index.php/login")!
        let data = try! JSONSerialization.data(withJSONObject: jsonData, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = data as Data
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // catch if there is a problem with the data
            guard let data else {
                completion(.failure(DataError.invalidDataAuth))
                return
            }
            // catch if the response is not successful
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(DataError.invalidResponseAuth))
                return
            }
            
            // good to go. convert the result to json and get the token
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let oauth = json["oauth"] as? [String: Any], let token = oauth["access_token"] as? String {
                        // got the token, proceed with the actual response
                        completion(.success(token))
                    } else {
                        completion(.failure(DataError.typeConversionAuth))
                    }
                }
            } catch let error as NSError {
                completion(.failure(DataError.message(error)))
            }
        }
        task.resume()
    }
    
    // function to fetch the actual data
    private func getResources(token: String, completion: @escaping (Result<[TaskModel], Error>) -> Void) {
        // we can force unwrap the URL since we know it's a valid, constant link
        let url = URL(string: "https://api.baubuddy.de/dev/index.php/v1/tasks/select")!
        
        var request = URLRequest(url: url)
        //var request = NSMutableURLRequest(url: NSURL(string: "https://api.baubuddy.de/index.php/login")! as URL,
          //                                cachePolicy: .useProtocolCachePolicy,
           //                               timeoutInterval: 10.0)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            // catch if there is a problem with the data
            guard let data else {
                completion(.failure(DataError.invalidData))
                return
            }
            // catch if the response is not successful
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(DataError.invalidResponse))
                return
            }
                  
            // good to go. convert the result to json using our model
            if let tasks = try? JSONDecoder().decode([TaskModel].self, from: data) {
                completion(.success(tasks))
            } else {
                completion(.failure(DataError.typeConversion))
            }
        }
        task.resume()
    }
    
    func fetch() {
        self.loading = true
        
        self.getAuth { result in
            switch result {
            case .success(let token):
                self.getResources(token: token) { resourceResult in
                    // make the the publishing happens on the main thread
                    DispatchQueue.main.async {
                        switch resourceResult {
                        case .success(let tasks):
                            print("Successfully fetched the tasks.")
                            self.saveToCoreData(tasks: tasks)
                        case .failure(let failure):
                            print(failure)
                        }
                        self.loading = false
                    }
                }
            case .failure(let failure):
                print(failure)
                self.loading = false
            }
        }
    }
    
    func saveToCoreData(tasks: [TaskModel]) {
        for task in tasks {
            let coreDataTask = Task(context: PersistenceController.shared.container.viewContext)
        
            coreDataTask.task = task.task
            coreDataTask.title = task.title
            coreDataTask.taskDescription = task.taskDescription
            coreDataTask.sort = task.sort
            coreDataTask.wageType = task.wageType
            coreDataTask.businessUnitKey = task.businessUnitKey
            coreDataTask.businessUnit = task.businessUnit
            coreDataTask.parentTaskID = task.parentTaskID
            coreDataTask.preplanningBoardQuickSelect = task.preplanningBoardQuickSelect
            coreDataTask.colorCode = task.colorCode
            coreDataTask.workingTime = task.workingTime
            coreDataTask.isAvailableInTimeTrackingKioskMode = task.isAvailableInTimeTrackingKioskMode ?? false
            
            PersistenceController.shared.save()
        }
    }
}
