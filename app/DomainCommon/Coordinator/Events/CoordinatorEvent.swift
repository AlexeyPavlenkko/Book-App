//
//  CoordinatorEvent.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

protocol CoordinatorEvent {}

extension CoordinatorEvent {
    
    var identifier: String { String(reflecting: self) }
    
}
