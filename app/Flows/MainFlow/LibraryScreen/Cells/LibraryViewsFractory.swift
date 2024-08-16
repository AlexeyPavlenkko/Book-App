//
//  LibraryViewsFractory.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit

struct LibraryViewsFractory {
    
    static func cell(content: LibrarySection.RowCellType, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch content {
        case .bannerCell(let bannerContent):
            let bannerCell = collectionView.dequeueReusableCell(indexPath, cellType: LibraryBannerCell.self)
            bannerCell.apply(.init(slides: bannerContent.content, clickAction: bannerContent.clickAction))
            
            return bannerCell
            
        case .bookCell(let bookContent):
            let bookInfo = bookContent.bookInfo
            let bookCell = collectionView.dequeueReusableCell(indexPath, cellType: LibraryBookCell.self)
            bookCell.apply(.init(coverUrl: bookInfo.coverUrl, titleText: bookInfo.name))
            
            return bookCell
        }
    }
    
    static func header(
        section: LibrarySection,
        collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            elementKind: kind, indexPath: indexPath, viewType: LibraryHeaderView.self
        )
        typealias Colors = AppResources.Shared.Colors
        header.apply(.init(
            headerText: section.title,
            headerTextColor: section.type == .banner ? Colors.primaryPink : Colors.white()
        ))
        
        return header
    }
    
}
