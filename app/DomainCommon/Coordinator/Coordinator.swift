//
//  Coordinator.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

// MARK: - Coordinator

class Coordinator {
    
    enum EventDistributionMode {
        
        case fromChildNode
        case fromChildCoordinator
        case formParentCoordinator
        
    }
    
    private let parentCoordinator: Coordinator?
    private var childCoordinators = NSHashTable<Coordinator>.weakObjects()
    private var childNodes = NSHashTable<CoordinatorNode>.weakObjects()
    
    private let logger = CoordinatorLogger()
    
    init(parentCoordinator: Coordinator?) {
        self.parentCoordinator = parentCoordinator
        parentCoordinator?.addChildCoordinator(self)
    }
    
    func handleCoordinatorEvent(_ event: CoordinatorEvent, recieved from: EventDistributionMode) -> Bool {
        true
        // This function must be overrided!
    }
    
    fileprivate func processCoordinatorNodeEvent(_ event: CoordinatorEvent, recieved from: EventDistributionMode) {
        guard !handleCoordinatorEvent(event, recieved: from) else {
            logger.logEvent(.coordinatorEvent(event.identifier), with: .wasHandeled, in: .coordinator(identifier))
            return
        }
        
        logger.logEvent(.coordinatorEvent(event.identifier), with: .wasNotHandeled, in: .coordinator(identifier))
        
        switch from {
        case .fromChildNode, .fromChildCoordinator:
            raiseCoordinatorEvent(event)
        case .formParentCoordinator:
            propagateCoordinatorEvent(event)
        }
    }
    
    private func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.add(coordinator)
    }
    
    fileprivate func addNode(_ node: CoordinatorNode) {
        childNodes.add(node)
    }
    
    final func propagateCoordinatorNodeEvent(_ event: CoordinatorNodeEvent) {
        if childNodes.count != 0 {
            logger.logEvent(.coordinatorNodeEvent(event.identifier), with: .wasSent, in: .coordinator(identifier))
        }
        childNodes.allObjects.reversed().forEach { node in
            if node.handleCoordinationNodeEvent(event) {
                logger.logEvent(.coordinatorNodeEvent(event.identifier), with: .wasHandeled, in: .coordinatorNode(node.identifier))
                return
            }
            logger.logEvent(.coordinatorNodeEvent(event.identifier), with: .wasNotHandeled, in: .coordinatorNode(node.identifier))
        }
    }
    
    final func raiseCoordinatorEvent(_ event: CoordinatorEvent) {
        guard let parentCoordinator = parentCoordinator else {
            propagateCoordinatorEvent(event)
            return
        }
        
        logger.logEvent(.coordinatorEvent(event.identifier), with: .wasSent, in: .coordinator(identifier))
        parentCoordinator.processCoordinatorNodeEvent(event, recieved: .fromChildCoordinator)
    }
    
    private final func propagateCoordinatorEvent(_ event: CoordinatorEvent) {
        if childCoordinators.count != 0 {
            logger.logEvent(.coordinatorEvent(event.identifier), with: .wasSent, in: .coordinator(identifier))
        }
        childCoordinators.allObjects.reversed().forEach { coordinator in
            coordinator.processCoordinatorNodeEvent(event, recieved: .formParentCoordinator)
        }
    }
    
    deinit { logger.logDeinit(of: .coordinator(identifier)) }
}

extension Coordinator {
    var identifier: String { String(describing: Self.self) }
}

// MARK: - CoordinatorNode

class CoordinatorNode {
    private let parent: Coordinator
    private let logger = CoordinatorLogger()
    
    public init(parent: Coordinator) {
        self.parent = parent
        parent.addNode(self)
    }
    
    func handleCoordinationNodeEvent(_ event: CoordinatorNodeEvent) -> Bool {
        false
        // This function must be overrided!
    }
    
    final func raiseEventToCoordinator(_ event: CoordinatorEvent) {
        logger.logEvent(.coordinatorEvent(event.identifier), with: .wasSent, in: .coordinatorNode(identifier))
        parent.processCoordinatorNodeEvent(event, recieved: .fromChildNode)
    }
    
    deinit { logger.logDeinit(of: .coordinatorNode(identifier)) }
}

extension CoordinatorNode {
    var identifier: String { String(describing: Self.self) }
}
