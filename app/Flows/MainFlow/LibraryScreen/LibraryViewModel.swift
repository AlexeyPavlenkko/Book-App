//
//  LibraryViewModel.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation
import Combine

final class LibraryViewModel: CoordinatorNode {
    
    //MARK: Properties
    
    let updateContentAction = PassthroughSubject<Void, Never>()
    
    private(set) var librarySections: [LibrarySection] = []
    private let booksService: AppBookService
    
    //MARK: Init
    
    init(_ coordinator: Coordinator, bookService: AppBookService) {
        self.booksService = bookService
        super.init(parent: coordinator)
    }
    
    //MARK: Methods
    
    func fetchLibraryInfo() {
        booksService.getLibraryInfo { [weak self] result in
            switch result {
            case .success(let libraryInfo):
                self?.generateCellsInfo(bannersInfo: libraryInfo.bannersInfo, booksInfo: libraryInfo.booksInfo)
                
            case .failure(let error):
                // Error handling...
                print(error)
            }
        }
    }
    
    func didSelectBook(_ indexPath: IndexPath) {
        guard let selectedBook = librarySections[indexPath.section].rows[indexPath.row] as? LibraryBookSectionContent else { return }
        didSelectBook(selectedBook.bookInfo.id)
    }
    
    private func generateCellsInfo(bannersInfo: [BannerInfo], booksInfo: [BookInfo]) {
        var sections: [LibrarySection] = []
        
        let bannerSectionContent = LibraryBannerSectionContent(content: bannersInfo) { [weak self] id in
            self?.didSelectBook(id)
        }
        let bannersSection =  LibrarySection(
            title: AppResources.MainResources.Strings.library,
            type: .banner,
            rows: [bannerSectionContent]
        )
        sections.append(bannersSection)
        
        let booksDictionary = Dictionary(grouping: booksInfo, by: { $0.genre} )
        booksDictionary.forEach { genreName, books in
            let bookSection = LibrarySection(
                title: genreName,
                type: .books,
                rows: books.map { LibraryBookSectionContent(bookInfo: $0) })
            
            sections.append(bookSection)
        }
        
        librarySections = sections
        updateContentAction.send(())
    }
    
    private func didSelectBook(_ id: Int) {
        raiseEventToCoordinator(MainCoordinatorEvent.openBookDetails(id: id))
    }
    
}
