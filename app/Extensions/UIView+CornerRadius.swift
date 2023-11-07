//
//  UIView+CornerRadius.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit

extension UIView {
    
    func makeViewRound() {
        addCornerRadius(min(bounds.height, bounds.width) / 2)
    }
    
    func addCornerRadius(_ radius: CGFloat, corners: CACornerMask = [
        .layerMinXMinYCorner,
        .layerMinXMaxYCorner,
        .layerMaxXMaxYCorner,
        .layerMaxXMinYCorner
    ]) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        layer.masksToBounds = true
    }
    
}
