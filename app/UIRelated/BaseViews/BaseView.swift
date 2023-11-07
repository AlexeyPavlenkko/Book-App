//
//  BaseView.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import UIKit

class BaseView: UIView {
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
