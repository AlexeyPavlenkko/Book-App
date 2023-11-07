//
//  UINavigationItem+removeBackTitle.swift
//  app
//
//  Created by Алексей Павленко on 07.11.2023.
//

import UIKit

extension UINavigationItem {
    
    func removeBackButtonTitle() {
        backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}
