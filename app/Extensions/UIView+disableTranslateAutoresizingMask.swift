//
//  UIView+disableTranslateAutoresizingMask.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import UIKit

extension UIView {
    
    func disableTranslateAutoresizingMask() {
       translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
}
