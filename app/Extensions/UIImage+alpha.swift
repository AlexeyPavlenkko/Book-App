//
//  UIImage+alpha.swift
//  app
//
//  Created by Алексей Павленко on 07.11.2023.
//

import UIKit

extension UIImage {
    
    func withAlpha(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}

