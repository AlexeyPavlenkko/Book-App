//
//  AppCoordinatorAssembly.swift
//  app
//
//  Created by Алексей Павленко on 07.11.2023.
//

import Foundation

final class AppCoordinatorAssembly {
    
    func assemble(_ container: DIContainer) {
        container.register(NetworkService.self) {
            RemoteConfigService()
        }
    }
    
}
