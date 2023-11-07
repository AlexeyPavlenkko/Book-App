//
//  MainCoordinatorAssembly.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

final class MainCoordinatorAssembly {
    
    func assemble(_ container: DIContainer) {
        let networkService: NetworkService = container.resolve()
        
        container.register(AppBookService.self) {
            BookService(networkService: networkService)
        }
    }
    
}
