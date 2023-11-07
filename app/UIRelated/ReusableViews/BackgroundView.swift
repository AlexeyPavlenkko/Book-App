//
//  BackgroundView.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import UIKit

final class BackgroundView: BaseView {
    
    private let view: UIView
    
    init(_ view: UIView) {
        self.view = view
        super.init()
        
        layoutView()
    }
    
    init(_ fabric: () -> UIView) {
        self.view = fabric()
        super.init()
        
        layoutView()
    }
    
    private func layoutView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
