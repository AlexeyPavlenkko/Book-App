//
//  LibrarySectionContent.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

struct LibraryBannerSectionContent {
    
    let content: [BannerInfo]
    let clickAction: (Int) -> Void
    
}

struct LibraryBookSectionContent {
    
    let bookInfo: BookInfo
    
}
