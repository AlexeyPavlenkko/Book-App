//
//  BookServiceRequest.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

enum BookServiceRequest: String, NetworkRequest {
    
    case allData = "json_data"
    case carouselDetails = "details_carousel"
    
    var path: String { self.rawValue }
    
}
