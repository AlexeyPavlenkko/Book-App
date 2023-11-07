//
//  LibraryBookCell.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit

final class LibraryBookCell: UICollectionViewCell, Reusable {
    
    //MARK: Properties
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            imageView.alpha = isSelected ? 0.7 : 1
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            imageView.alpha = isHighlighted ? 0.7 : 1
        }
    }
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.cancelImageFetching()
    }
    
    //MARK: Methods
    
    private func setupViews() {
        [imageView, titleLabel].forEach { $0.disableTranslateAutoresizingMask() }
        setupImageView()
        setupTitleLabel()
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = AppResources.Shared.Colors.primaryGray
        imageView.addCornerRadius(16.0)
        
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.25)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.textColor = AppResources.Shared.Colors.white(withAlphaComponent: 0.7)
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    func apply(_ configuration: Configuration) {
        imageView.setImage(from: configuration.coverUrl)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.81
        let attr = NSAttributedString(string: configuration.titleText, attributes: [
            .font: AppResources.Shared.Fonts.nunitoSansSemiBold(ofSize: 16),
            .paragraphStyle: paragraphStyle,
            .kern: -0.41
        ])
        
        titleLabel.attributedText = attr
        titleLabel.lineBreakMode = .byTruncatingTail
    }
    
}

//MARK: - Configuration

extension LibraryBookCell {
    
    struct Configuration {
        
        let coverUrl: URL
        let titleText: String
        
    }
    
}
