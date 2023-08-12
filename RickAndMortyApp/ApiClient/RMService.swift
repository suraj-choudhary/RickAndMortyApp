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
    
    
    /// Send Rick and morty Api call
    /// - Parameters:
    ///   - request: request instance
    ///   - completion: call back with data and erro
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
        
    }
    
}
