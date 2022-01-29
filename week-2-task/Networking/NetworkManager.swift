//
//  NetworkManager.swift
//  week-2-task
//
//  Created by Mohammed Al-Quraini on 1/28/22.
//

import UIKit

struct NetworkManager {
    
    func performRequest<T : Codable>(_ model : T.Type, completion: @escaping (Result<T, NetworkError>) -> Void )   {
        
        // 1. Create a url
        guard let url = URL(string: NetworkURLs.baseURL)
        else {
            completion(.failure(.badURL))
                       return
        }
        
        // 2. Create a url session
        let session = URLSession(configuration: .default)
               
        // 3. Give the session a task
        let task = session.dataTask(with: url) { data , response, error in
            if let error = error {
                completion(.failure(.other(error)))
                       return
                   }
            
        //4. Create a property for the decoded data
        if let safeData = data {
                do {
                    let response = try JSONDecoder().decode(model, from: safeData)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.other(error)))
                }
            
            }
            
        }
        
        //5. Resume the task
        task.resume()
}
}
