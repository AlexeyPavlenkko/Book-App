//
//  MainResources.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit

extension AppResources {
    
    enum MainResources {
        
        // MARK: - Images
        
        enum Images {
            
            static let blanket: UIImage = UIImage(named: "blanket")!
            static let backArrow: UIImage = UIImage(named: "back_arrow")!
            
        }
        
        // MARK: - Strings
        
        enum Strings {
            
            static let library: String = "Library"
            static let readNow: String = "Read Now"
            static let readers: String = "Readers"
            static let likes: String = "Likes"
            static let quotes: String = "Quotes"
            static let genre: String = "Genre"
            static let summary: String = "Summary"
            static let recommended: String = "You will also like"
            
        }
    }
    
}
