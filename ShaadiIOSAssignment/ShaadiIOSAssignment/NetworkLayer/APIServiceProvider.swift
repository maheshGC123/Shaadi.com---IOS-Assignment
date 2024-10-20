//
//  APIServiceProvider.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 19/10/24.
//
import Foundation

class APIServiceProvider {
    
    // HTTP Method Enum to support different types of requests
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    // Generic function to fetch data from any API and decode it into the provided model
    func fetchData<T: Decodable>(
        from urlString: String,
        method: HTTPMethod = .GET,
        body: Data? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        // Add headers if provided
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Execute the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }.resume()
    }
    
    // Helper function to send POST request with JSON body
    func sendPostRequest<T: Decodable>(
        to urlString: String,
        body: [String: Any],
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            fetchData(from: urlString, method: .POST, body: jsonData, headers: headers, completion: completion)
        } catch let jsonError {
            completion(.failure(jsonError))
        }
    }
    
    // Helper function to send PUT request with JSON body
    func sendPutRequest<T: Decodable>(
        to urlString: String,
        body: [String: Any],
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            fetchData(from: urlString, method: .PUT, body: jsonData, headers: headers, completion: completion)
        } catch let jsonError {
            completion(.failure(jsonError))
        }
    }
    
    // Helper function to send DELETE request
    func sendDeleteRequest<T: Decodable>(
        to urlString: String,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        fetchData(from: urlString, method: .DELETE, headers: headers, completion: completion)
    }
}
