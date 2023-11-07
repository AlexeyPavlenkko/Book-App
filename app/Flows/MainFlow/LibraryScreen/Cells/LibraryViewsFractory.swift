//
//  LibraryViewsFractory.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit

struct LibraryViewsFractory {
    
    static func cell(content: LibrarySectionContent, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch content {
        case is LibraryBannerSectionContent:
            let bannerContent = content as! LibraryBannerSectionContent
            let bannerCell = collectionView.dequeueReusableCell(indexPath, cellType: LibraryBannerCell.self)
            bannerCell.apply(.init(slides: bannerContent.content, clickAction: bannerContent.clickAction))
            
            return bannerCell
            
        case is LibraryBookSectionContent:
            let bookContent = content as! LibraryBookSectionContent
            let bookInfo = bookContent.bookInfo
            let bookCell = collectionView.dequeueReusableCell(indexPath, cellType: LibraryBookCell.self)
            bookCell.apply(.init(coverUrl: bookInfo.coverUrl, titleText: bookInfo.name))
            
            return bookCell
            
        default:
            fatalError("Unsupported section content: \(content.self)")
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
