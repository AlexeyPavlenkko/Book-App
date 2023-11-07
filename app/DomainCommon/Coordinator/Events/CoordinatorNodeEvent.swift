//
//  CoordinatorNodeEvent.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

protocol CoordinatorNodeEvent {}

extension CoordinatorNodeEvent {
    
    var identifier: String { String(reflecting: self) }
    
}

