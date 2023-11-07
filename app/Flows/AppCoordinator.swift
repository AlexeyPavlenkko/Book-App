//
//  AppCoordinator.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import UIKit
import Firebase

// MARK: - AppCoordinatorEvent

enum AppCoordinatorEvent: CoordinatorEvent {
    
    case splashPresentationEnded
    
}

// MARK: - AppCoordinator

final class AppCoordinator: Coordinator {
    
    // MARK: Properties
    
    private let launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    private let container: DIContainer
    
    private var window: UIWindow!
    
    // MARK: Init
    
    init(launchOptions: [UIApplication.LaunchOptionsKey : Any]?, container: DIContainer) {
        self.launchOptions = launchOptions
        self.container = container
        super.init(parentCoordinator: nil)
        
        AppCoordinatorAssembly().assemble(container)
    }
    
    // MARK: CoordinatorEvents Handler
    
    override func handleCoordinatorEvent(_ event: CoordinatorEvent, recieved from: Coordinator.EventDistributionMode) -> Bool {
        guard let event = event as? AppCoordinatorEvent else { return false }
        
        switch event {
        case .splashPresentationEnded:
            presentMainFlow()
        }
        
        return true
    }
    
    // MARK: Methods
    
    func execute(in window: UIWindow) {
        self.window = window
        
        presentSplashFlow()
    }
    
    private func presentSplashFlow() {
        let splashCoordinator = SplashCoordinator(parent: self, container: container)
        let splashViewController = splashCoordinator.createFlow()
        
        setRootViewController(splashViewController)
    }
    
    private func presentMainFlow() {
        let mainCoordinator = MainCoordinator(parent: self, container: container)
        let viewController = mainCoordinator.createFlow()
        
        setRootViewController(viewController)
    }
    
    private func setRootViewController(_ viewController: UIViewController, completion: ((Bool) -> Void)? = nil) {
        guard let window = window else { return }
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {},
            completion: completion
        )
    }
    
}
