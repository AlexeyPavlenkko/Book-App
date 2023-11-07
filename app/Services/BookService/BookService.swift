//
//  BookService.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

protocol AppBookService {
    
    func getLibraryInfo(_ completion: @escaping (Result<LibraryInfo, Error>) -> Void)
    func getBooksInfoForCarousel(_ completion: @escaping (Result<[BookInfo], Error>) -> Void)
    func getRecommendedBooksInfo(_ completion: @escaping (Result<[BookInfo], Error>) -> Void)
    
}

final class BookService: AppBookService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getLibraryInfo(_ completion: @escaping (Result<LibraryInfo, Error>) -> Void) {
        let request = BookServiceRequest.allData
        let parser = DecodableParser<LibraryInfo>()
        
        networkService.performRequest(request, parser: parser) { completion($0) }
    }
    
    func getBooksInfoForCarousel(_ completion: @escaping (Result<[BookInfo], Error>) -> Void) {
        let request = BookServiceRequest.carouselDetails
        let parser = DecodableParser<[BookInfo]>(keyPath: "books")
        
        networkService.performRequest(request, parser: parser) { completion($0) }
    }
    
    func getRecommendedBooksInfo(_ completion: @escaping (Result<[BookInfo], Error>) -> Void) {
        let request = BookServiceRequest.allData
        let parser = DecodableParser<RecommendedBooks>()
        
        networkService.performRequest(request, parser: parser) { result in
            switch result {
            case .success(let info):
                let recommendedBooks = info.allBooks.filter { info.recommendedBooksId.contains($0.id) }
                completion(.success(recommendedBooks))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
