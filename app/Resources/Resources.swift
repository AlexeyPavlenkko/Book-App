//
//  Resources.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import UIKit

enum AppResources {
    
    enum Shared {
        
        // MARK: - Colors
        enum Colors {
            
            static let charcoal: UIColor = UIColor(named: "charcoal")!
            static let indicatorGray: UIColor = UIColor(named: "indicator_gray")!
            static let primaryBlack: UIColor = UIColor(named: "primary_black")!
            static let primaryGray: UIColor = UIColor(named: "primary_gray")!
            static let primaryPink: UIColor = UIColor(named: "primary_pink")!
            static let secondaryGray: UIColor = UIColor(named: "secondary_gray")!
            static let secondaryWhite: UIColor = UIColor(named: "secondary_white")!
            static let lightPink: UIColor = UIColor(named: "light_pink")!
            static let primaryPurple: UIColor = UIColor(named: "primary_purple")!
            
            static func white(withAlphaComponent alpha: CGFloat = 1.0) -> UIColor {
                UIColor.white.withAlphaComponent(alpha)
            }
            
            static func black(withAlphaComponent alpha: CGFloat = 1.0) -> UIColor {
                UIColor.black.withAlphaComponent(alpha)
            }
            
        }
        
        // MARK: - Fonts
        enum Fonts {
            
            static func nunitoSansBold(ofSize size: CGFloat) -> UIFont {
                UIFont(name: "NunitoSans-Bold", size: size)!
            }
            
            static func nunitoSansSemiBold(ofSize size: CGFloat) -> UIFont {
                UIFont(name: "NunitoSans-SemiBold", size: size)!
            }
            
            static func nunitoSansExtraBold(ofSize size: CGFloat) -> UIFont {
                UIFont(name: "NunitoSans-ExtraBold", size: size)!
            }
            
            static func georgiaBoldItalic(ofSize size: CGFloat) -> UIFont {
                UIFont(name: "Georgia-BoldItalic", size: size)!
            }
            
        }
        
    }
    
}
