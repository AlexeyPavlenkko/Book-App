//
//  NetworkService.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

protocol NetworkService {
    
    func performRequest<Parser: ResponseParser>(
        _ request: NetworkRequest,
        parser: Parser,
        completion: @escaping (Result<Parser.Representation, Error>) -> Void
    )
    
}
