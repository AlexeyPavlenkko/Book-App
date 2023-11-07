//
//  BookInfo.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

struct BookInfo: Decodable {
    
    let id: Int
    let name: String
    let summary: String
    let genre: String
    let author: String
    let likes: String
    let quotes: String
    let views: String
    let coverUrl: URL
    
    var debugDescription: String {
        "Name: \(name), Genre: \(genre), author: \(author)"
    }
    
}
