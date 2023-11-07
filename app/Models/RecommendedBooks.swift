//
//  RecommendedBooks.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

struct RecommendedBooks: Decodable {
    
    let allBooks: [BookInfo]
    let recommendedBooksId: [Int]
    
    enum CodingKeys: String, CodingKey {
        case allBooks = "books"
        case recommendedBooksId = "youWillLikeSection"
    }
    
}
