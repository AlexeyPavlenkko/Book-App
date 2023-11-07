//
//  StatisticDoubleLabel.swift
//  app
//
//  Created by Алексей Павленко on 07.11.2023.
//

import UIKit

final class StatisticDoubleLabel: BaseView {
    
    //MARK: Properties
    
    private let stackView = UIStackView()
    private let countLabel = UILabel()
    private let topicLabel = UILabel()
    
    //MARK: Lifecycle
    
    override init() {
        super.init()
        
        setupViews()
    }
    
    //MARK: Methods
    
    private func setupViews() {
        stackView.axis = .vertical
        stackView.disableTranslateAutoresizingMask()
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        countLabel.numberOfLines = 1
        countLabel.textColor = AppResources.Shared.Colors.primaryBlack
        countLabel.font = AppResources.Shared.Fonts.nunitoSansBold(ofSize: 18)
        countLabel.textAlignment = .center
        countLabel.lineBreakMode = .byTruncatingTail
        
        topicLabel.numberOfLines = 1
        topicLabel.textColor = AppResources.Shared.Colors.primaryGray
        topicLabel.font = AppResources.Shared.Fonts.nunitoSansSemiBold(ofSize: 12)
        topicLabel.textAlignment = .center
        topicLabel.lineBreakMode = .byTruncatingTail
        
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(topicLabel)
    }
    
    func apply(_ configuration: Configuration) {
        countLabel.text = configuration.countText
        topicLabel.text = configuration.topicName
    }
    
}

//MARK: - Configuration

extension StatisticDoubleLabel {
    
    struct Configuration {
        
        let countText: String
        let topicName: String
        
    }
    
}
