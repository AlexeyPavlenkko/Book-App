//
//  JSONDecoder+default.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

public extension JSONDecoder {
    static let `default`: JSONDecoder = {
        let decoder = JSONDecoder().applyingDefaultParameters()
        return decoder
    }()
    
    func applyingDefaultParameters() -> Self {
        self.keyDecodingStrategy = .convertFromSnakeCase
        return self
    }
}
