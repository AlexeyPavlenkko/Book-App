//
//  RecommendedBookView.swift
//  app
//
//  Created by Алексей Павленко on 07.11.2023.
//

import UIKit

final class RecommendedBookView: BaseView {
    
    //MARK: Properties
    
    private let coverImageView = UIImageView()
    private let titleLabel = UILabel()
    
    //MARK: Lifecycle
    
    override init() {
        super.init()
        
        setupViews()
    }
    
    //MARK: Methods
    
    private func setupViews() {
        let subs = [coverImageView, titleLabel]
        subs.forEach { $0.disableTranslateAutoresizingMask() }
        addSubviews(subs)
        
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.addCornerRadius(16.0)
        
        titleLabel.numberOfLines = 2
        titleLabel.textColor = AppResources.Shared.Colors.charcoal
        titleLabel.font = AppResources.Shared.Fonts.nunitoSansSemiBold(ofSize: 16.0)
        titleLabel.textAlignment = .left
        titleLabel.lineBreakMode = .byTruncatingTail
        
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 150.0),
            coverImageView.widthAnchor.constraint(equalToConstant: 120.0),
            
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 4.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func apply(_ configuration: Configuration) {
        coverImageView.setImage(from: configuration.coverUrl)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.81
        let attr = NSAttributedString(string: configuration.titleName, attributes: [
            .font: AppResources.Shared.Fonts.nunitoSansSemiBold(ofSize: 16),
            .paragraphStyle: paragraphStyle,
            .kern: -0.41
        ])
        
        titleLabel.attributedText = attr
        titleLabel.lineBreakMode = .byTruncatingTail
    }
    
}

//MARK: - Configuration

extension RecommendedBookView {
    
    struct Configuration {
        
        let titleName: String
        let coverUrl: URL
        
    }
    
}
