//
//  RMRequest.swift
//  RickAndMortyApp
//
//  Created by suraj kumar on 09/08/23.
//

import Foundation
/// Object that reprsent a single Api call
final class RMRequest {
    
    /// API Constants
    private struct Constant {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desire end point
    private let endPoint: RMEndPoint
    
    
    /// path component for api if any
    private let pathComponent: [String]
    
    
    /// query paramter if any
    private let queryParameter: [URLQueryItem]
    
    ///Constructed url from string formate
    private var urlString: String {
        var string = Constant.baseUrl
        string += "/"
        string += endPoint.rawValue
        
        if !pathComponent.isEmpty {
            string += "/"
            pathComponent.forEach({
                string += "\($0)"
            })
        }
        
        if !queryParameter.isEmpty {
            string += "?"
            
            let argumentString = queryParameter.compactMap({
                
                guard let value = $0.value else {
                    return nil
                }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    /// computed consturcted url
    public var url: URL? {
        return URL(string: urlString)
    }
    // MARK:
    
    public let httpMethod = "GET"
    
    
    /// Construct rquest
    /// - Parameters:
    ///   - endPoint: target endpioint
    ///   - pathComponent: colletion of path component
    ///   - queryParameter: colletion of query parameter
    public init(endPoint: RMEndPoint, pathComponent: [String] = [], queryParameter: [URLQueryItem] = []) {
        self.endPoint = endPoint
        self.pathComponent = pathComponent
        self.queryParameter = queryParameter
    }
}

