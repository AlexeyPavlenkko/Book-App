//
//  DecodableParser.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

enum DecodableParserError: Error {
    
    case keyNotFound
    case notValidJSONObject
    
}

final class DecodableParser<T: Decodable>: ResponseParser {
    
    typealias Representation = T
    
    private let keyPath: String?
    private let decoder: JSONDecoder
    
    init(keyPath: String? = nil, decoder: JSONDecoder = .default) {
        self.keyPath = keyPath
        self.decoder = decoder
    }
    
    func parse(_ data: Data) -> Result<T, Error> {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            return parse(json)
        } catch {
            return .failure(error)
        }
    }
    
    func parse(_ object: Any) -> Result<T, Error> {
        do {
            let value = try valueForKeyPath(in: object)
            
            guard JSONSerialization.isValidJSONObject(value) else {
                throw DecodableParserError.notValidJSONObject
            }
            let data = try JSONSerialization.data(withJSONObject: value)
            let decoded = try decoder.decode(Representation.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(error)
        }
    }
    
    func parseAsync(_ data: Data, queue: DispatchQueue = .global(), completion: @escaping (Result<T, Error>) -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }
            completion(self.parse(data))
        }
    }
    
    func parseAsync(_ object: Any, queue: DispatchQueue = .global(), completion: @escaping (Result<T, Error>) -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }
            completion(self.parse(object))
        }
    }
    
    private func valueForKeyPath(in object: Any) throws -> Any {
        if let keyPath = keyPath, let dictionary = object as? JSON {
            if let value = dictionary[keyPath] {
                return value
            }
            throw DecodableParserError.keyNotFound
        } else {
            return object
        }
    }
    
}
