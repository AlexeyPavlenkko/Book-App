//
//  ResponseParser.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

protocol ResponseParser {
    
    associatedtype Representation
    
    func parse(_ data: Data) -> Result<Representation, Error>
    func parse(_ object: Any) -> Result<Representation, Error>
    func parseAsync(_ data: Data, queue: DispatchQueue, completion: @escaping (Result<Representation, Error>) -> Void)
    func parseAsync(_ object: Any, queue: DispatchQueue, completion: @escaping (Result<Representation, Error>) -> Void)
    
}
