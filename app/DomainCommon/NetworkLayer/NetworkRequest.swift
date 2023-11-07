//
//  NetworkRequest.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

enum HTTPMethod: String {
    
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
    
}

protocol NetworkRequest {
    
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var request: URLRequest? { get }
    var postData: Data? { get }
    var httpMethod: HTTPMethod { get }
    
}

extension NetworkRequest {
    
    var baseURL: String { "" }
    var queryItems: [URLQueryItem]? { nil }
    var postData: Data? { nil }
    var httpMethod: HTTPMethod { .get }
    
    var request: URLRequest? {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queryItems
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        
        if let data = postData {
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
    
}
