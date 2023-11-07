//
//  MainCoordinator.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import UIKit

//MARK: - MainCoordinatorEvent

enum MainCoordinatorEvent: CoordinatorEvent {
    
    case openBookDetails(id: Int)
    
}

//MARK: - MainCoordinator

final class MainCoordinator: Coordinator, Flow {
    
    // MARK: Properties
    
    weak var rootViewController: UIViewController?
    
    private let container: DIContainer
    
    // MARK: Init
    
    init(parent: Coordinator?, container: DIContainer?) {
        self.container = DIContainer(container)
        super.init(parentCoordinator: parent)
        
        MainCoordinatorAssembly().assemble(self.container)
    }
    
    // MARK: CoordinatorEvents Handler
    
    override func handleCoordinatorEvent(_ event: CoordinatorEvent, recieved from: Coordinator.EventDistributionMode) -> Bool {
        guard let event = event as? MainCoordinatorEvent else { return false }
        
        switch event {
        case .openBookDetails(let id):
            pushBookDetails(id)
        }
        
        return true
    }
    
    // MARK: Methods
    
    private func pushBookDetails(_ bookId: Int) {
        let viewModel = BookDetailsViewModel(self, preselectedBookId: bookId, booksService: container.resolve())
        let viewController = BookDetailsViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: CreateFlow
    
    func createFlow() -> UIViewController {
        let viewModel = LibraryViewModel(self, bookService: container.resolve())
        let viewController = LibraryViewController(viewModel: viewModel)
        let navigationController = AppNavigationController(rootViewController: viewController)
        rootViewController = navigationController
        
        return navigationController
    }
    
}
