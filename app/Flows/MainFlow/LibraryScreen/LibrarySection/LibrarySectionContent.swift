//
//  LibrarySectionContent.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

protocol LibrarySectionContent { }

struct LibraryBannerSectionContent: LibrarySectionContent {
    
    let content: [BannerInfo]
    let clickAction: (Int) -> Void
    
}

struct LibraryBookSectionContent: LibrarySectionContent {
    
    let bookInfo: BookInfo
    
}
