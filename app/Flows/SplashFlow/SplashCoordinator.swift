//
//  SplashCoordinator.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import UIKit

// MARK: - SplashCoordinatorEvent

enum SplashCoordinatorEvent: CoordinatorEvent {
    
    case loadingAnimationEnded
    
}

// MARK: - SplashCoordinator

final class SplashCoordinator: Coordinator, Flow {
    
    // MARK: Properties
    
    weak var rootViewController: UIViewController?
    private let container: DIContainer
    
    // MARK: Init
    
    init(parent: Coordinator?, container: DIContainer?) {
        self.container = DIContainer(container)
        super.init(parentCoordinator: parent)
    }
    
    // MARK: CoordinatorEvents Handler
    
    override func handleCoordinatorEvent(_ event: CoordinatorEvent, recieved from: Coordinator.EventDistributionMode) -> Bool {
        guard let event = event as? SplashCoordinatorEvent else { return false }
        
        switch event {
        case .loadingAnimationEnded:
            raiseCoordinatorEvent(AppCoordinatorEvent.splashPresentationEnded)
        }
        
        return true
    }
    
    // MARK: Functions
    
    func createFlow() -> UIViewController {
        let viewModel = SplashViewModel(self, splashDuration: 2.0)
        let viewController = SplashViewController(viewModel: viewModel)
        rootViewController = viewController
        
        return viewController
    }
    
}
