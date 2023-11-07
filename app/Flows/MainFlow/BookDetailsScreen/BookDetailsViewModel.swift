//
//  BookDetailsViewModel.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation
import Combine

final class BookDetailsViewModel: CoordinatorNode {
    
    //MARK: Properties
    
    private(set) var updateContentAction = PassthroughSubject<Void, Never>()
    private(set) var booksInfo: [BookInfo] = []
    private(set) var recommendedBooks: [BookInfo] = []
    
    private let preselectedBookId: Int
    private let booksService: AppBookService
    private let dispatchGroup = DispatchGroup()
    
    //MARK: Init
    
    init(_ coordinator: Coordinator, preselectedBookId: Int, booksService: AppBookService) {
        self.preselectedBookId = preselectedBookId
        self.booksService = booksService
        super.init(parent: coordinator)
    }
    
    //MARK: Methods
    
    func fetchContent() {
        dispatchGroup.enter()
        booksService.getBooksInfoForCarousel { [weak self] result in
            switch result {
            case .success(let booksInfo):
                self?.booksInfo = booksInfo
                
            case .failure(let error):
                // Error handling
                print(error)
            }
            self?.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        booksService.getRecommendedBooksInfo { [weak self] result in
            switch result {
            case .success(let booksInfo):
                self?.recommendedBooks = booksInfo
                
            case .failure(let error):
                // Error handling
                print(error)
            }
            self?.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .global()) { [weak self] in
            self?.generatePagesInfo()
        }
    }
    
    private func generatePagesInfo() {
        guard let preselectedBookIndex = booksInfo.firstIndex(where: { $0.id == self.preselectedBookId }) else { return }
        var sortedBooksInfo = booksInfo
        let preselectedBook = sortedBooksInfo.remove(at: preselectedBookIndex)
        sortedBooksInfo.insert(preselectedBook, at: 0)
        booksInfo = sortedBooksInfo
        
        updateContentAction.send(())
    }
    
}
