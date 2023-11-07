//
//  SeparatorView.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit

final class SeparatorView: BaseView {
    
    private let separator = UIView()
    private let height: CGFloat
    private let horizontalPadding: CGFloat
    
    init(height: CGFloat = 1, horizontalPadding: CGFloat = 16.0) {
        self.height = height
        self.horizontalPadding = horizontalPadding
        super.init()
        
        setupSeparator()
    }
    
    private func setupSeparator() {
        separator.disableTranslateAutoresizingMask()
        separator.backgroundColor = AppResources.Shared.Colors.secondaryGray
        
        addSubview(separator)
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
            separator.topAnchor.constraint(equalTo: topAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
}
