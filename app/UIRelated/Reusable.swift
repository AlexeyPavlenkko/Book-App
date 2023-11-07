//
//  Reusable.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import Foundation

protocol Reusable: NSObject {
    
    static var reusableIdentifier: String { get }
    
}

extension Reusable {
    
    static var reusableIdentifier: String {
        String(describing: self)
    }
    
}
