

import Foundation

protocol NetworkProtocol {
    associatedtype Model: Decodable
    func performRequest(from url: String, completion: @escaping (Result<Model, NetworkError>) -> Void )
}


extension NetworkProtocol {
    func performRequest(from url: String, completion: @escaping (Result<Model, NetworkError>) -> Void )  {
        
        // 1. Create a url
        guard let url = URL(string: url)
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
        if let data = data {
                do {
                    let response = try JSONDecoder().decode(Model.self, from: data)
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
