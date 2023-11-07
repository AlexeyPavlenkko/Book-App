//
//  Flow.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import UIKit

protocol Flow: AnyObject {
    
    var rootViewController: UIViewController? { get set }
    
    @discardableResult
    func createFlow() -> UIViewController
    
}

extension Flow {
    
    var navigationController: UINavigationController? {
        rootViewController as? UINavigationController
    }
    
}
