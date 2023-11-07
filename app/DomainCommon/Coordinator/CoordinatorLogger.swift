//
//  CoordinatorLogger.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation
import OSLog

struct CoordinatorLogger {
    
    private let logger = Logger(subsystem: "Event", category: "Coordinator")
    
    enum EventAction {
        
        case wasHandeled
        case wasNotHandeled
        case wasSent
        
    }
    
    enum Source {
        
        case coordinator(String)
        case coordinatorNode(String)
        
    }
    
    enum EventType {
        
        case coordinatorEvent(String)
        case coordinatorNodeEvent(String)
        
    }
    
    func logEvent(_ event: EventType, with action: EventAction, in source: Source, enableNotHandeledLogging: Bool = false) {
        if !enableNotHandeledLogging && action == .wasNotHandeled { return }
        
        var message: String = ""
        
        switch source {
        case .coordinator(let name):
            message = "[C]-[\(name)] | "
        case .coordinatorNode(let name):
            message = "[CN]-[\(name)] | "
        }
        
        switch event {
        case .coordinatorEvent(let coordinatorEventName):
            message += "[CE]-[\(coordinatorEventName)] "
        case .coordinatorNodeEvent(let coordinatorNodeEventName):
            message += "[CNE]-[\(coordinatorNodeEventName)] "
        }
        
        switch action {
        case .wasHandeled:
            message += "was handeled ✅"
        case .wasNotHandeled:
            message += "was not handeled ⛔️"
        case .wasSent:
            message += "was sent 🚀"
        }
        
        logger.log(level: .debug, "\(message)")
    }
    
    func logDeinit(of source: Source) {
        switch source {
        case .coordinator(let string):
            logger.log(level: .debug, "[C]-[\(string)] deinited 💥")
        case .coordinatorNode(let string):
            logger.log(level: .debug, "[CN]-[\(string)] deinited 💥")
        }
    }
    
}
