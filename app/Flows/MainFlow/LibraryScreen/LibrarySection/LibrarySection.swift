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
    
    enum RowCellType {
        
        case bannerCell(LibraryBannerSectionContent)
        case bookCell(LibraryBookSectionContent)
        
    }
    
    let title: String
    let type: SectionType
    let rows: [RowCellType]
    
}
