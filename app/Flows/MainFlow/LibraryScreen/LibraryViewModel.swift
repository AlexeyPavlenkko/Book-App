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
        let selectedRow = librarySections[indexPath.section].rows[indexPath.row]
        switch selectedRow {
        case .bookCell(let content):
            didSelectBook(content.bookInfo.id)
        case.bannerCell: break
        }
    }
    
    private func generateCellsInfo(bannersInfo: [BannerInfo], booksInfo: [BookInfo]) {
        var sections: [LibrarySection] = []
        
        let bannerSectionContent = LibrarySection.RowCellType.bannerCell(LibraryBannerSectionContent(content: bannersInfo) { [weak self] id in
            self?.didSelectBook(id)
        })
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
                rows: books.map { LibrarySection.RowCellType.bookCell(LibraryBookSectionContent(bookInfo: $0)) })
            
            sections.append(bookSection)
        }
        
        librarySections = sections
        updateContentAction.send(())
    }
    
    private func didSelectBook(_ id: Int) {
        raiseEventToCoordinator(MainCoordinatorEvent.openBookDetails(id: id))
    }
    
}
