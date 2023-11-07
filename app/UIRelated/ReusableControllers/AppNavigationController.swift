//
//  AppNavigationController.swift
//  app
//
//  Created by Алексей Павленко on 07.11.2023.
//

import UIKit

final class AppNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        let backImage = AppResources.MainResources.Images.backArrow
        navigationBar.backIndicatorImage = backImage
        navigationBar.tintColor = .white
        navigationBar.backIndicatorTransitionMaskImage = backImage
        interactivePopGestureRecognizer?.isEnabled = false
    }
    
}
