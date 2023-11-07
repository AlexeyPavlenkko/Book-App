//
//  LibrarySection.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

struct LibrarySection {
    
    enum SectionType {
        
        case banner
        case books
        
    }
    
    let title: String
    let type: SectionType
    let rows: [LibrarySectionContent]
    
}
