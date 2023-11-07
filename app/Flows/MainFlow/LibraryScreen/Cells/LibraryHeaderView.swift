//
//  LibraryHeaderView.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit

final class LibraryHeaderView: UICollectionReusableView, Reusable {
    
    private let headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        headerLabel.disableTranslateAutoresizingMask()
        
        headerLabel.font = AppResources.Shared.Fonts.nunitoSansBold(ofSize: 20)
        headerLabel.textAlignment = .left
        
        addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func apply(_ configuration: Configuration) {
        headerLabel.text = configuration.headerText
        headerLabel.textColor = configuration.headerTextColor
    }
    
}

extension LibraryHeaderView {
    
    struct Configuration {
        
        let headerText: String
        let headerTextColor: UIColor
        
    }
    
}
