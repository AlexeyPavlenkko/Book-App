//
//  SplashViewModel.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

final class SplashViewModel: CoordinatorNode {
    
    private(set) var splashDuration: Double
    
    init(_ coordinator: Coordinator, splashDuration: Double) {
        self.splashDuration = splashDuration
        super.init(parent: coordinator)
    }
    
    func didEndSplashLoading() {
        raiseEventToCoordinator(SplashCoordinatorEvent.loadingAnimationEnded)
    }
    
}
