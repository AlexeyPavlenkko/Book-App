//
//  BannerInfo.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

struct BannerInfo: Decodable {
    
    let id: Int
    let bookId: Int
    let coverUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case id, bookId, coverUrl = "cover"
    }
    
}
