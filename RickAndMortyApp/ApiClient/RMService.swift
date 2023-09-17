//
//  RMService.swift
//  RickAndMortyApp
//
//  Created by suraj kumar on 09/08/23.
//

import Foundation

/// Primary Api service object to get back
final class RMService {
    
    /// Shared singlton instance
    static let shared = RMService()
    
    /// Private contructor
    private init() {}
    
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    /// Send rick and morty Api Calls
    /// - Parameters:
    ///   - request: request instance
    ///   - type: the type of object we expect to get back
    ///   - completion: callBack with data and error
    public func execute<T: Codable>(_ request: RMRequest, extpecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        
        guard  let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            //decode the result
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .json5Allowed)
                
                print(json)
                
                let result = try JSONDecoder().decode(type.self, from: data)
                
                completion(.success(result))
                
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        
        guard let url = rmRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
}
extension RMRequest {
    static let listCharacter = RMRequest(endPoint: .character)
}
