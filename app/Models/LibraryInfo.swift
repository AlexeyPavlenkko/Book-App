//
//  LibraryInfo.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

struct LibraryInfo: Decodable {
    
    let booksInfo: [BookInfo]
    let bannersInfo: [BannerInfo]
    
    enum CodingKeys: String, CodingKey {
        case booksInfo = "books"
        case bannersInfo = "topBannerSlides"
    }
    
}
