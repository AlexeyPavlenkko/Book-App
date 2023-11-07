//
//  UICollection+dequeue.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit

extension UICollectionView {
    
    final func registerReusableCell<T: UICollectionViewCell>(cellType: T.Type) where T: Reusable {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reusableIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(
        _ indexPath: IndexPath,
        cellType: T.Type = T.self
    ) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.reusableIdentifier) mathcing type \(cellType.self)")
        }
        
        return cell
    }
    
    final func registerReusableSupplementaryView<T: UICollectionReusableView>(
        elementKind: String,
        viewType: T.Type
    ) where T: Reusable {
        register(viewType.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: viewType.reusableIdentifier)
    }
    
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        elementKind: String,
        indexPath: IndexPath,
        viewType: T.Type = T.self
    ) -> T where T: Reusable {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: viewType.reusableIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("Failed to dequeue a supplementary view with identifier \(viewType.reusableIdentifier) mathcing type \(viewType.self)")
        }
        
        return view
    }
    
}
