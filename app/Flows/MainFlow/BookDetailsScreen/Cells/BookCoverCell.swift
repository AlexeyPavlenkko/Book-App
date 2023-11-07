//
//  BookCoverCell.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit

final class BookCoverCell: UICollectionViewCell, Reusable {
    
    enum State {
        case scaled
        case `default`
    }
    
    //MARK: Properties
    
    private let coverImageView = UIImageView()
    private let labelsStackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
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
        
        coverImageView.cancelImageFetching()
        transform = .identity
        labelsStackView.alpha = 0.0
    }
    
    //MARK: Private Methods
    
    private func setupViews() {
        [coverImageView, labelsStackView].forEach { $0.disableTranslateAutoresizingMask() }
        
        setupCoverImageView()
        setupLabelsStackView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    private func setupCoverImageView() {
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.backgroundColor = AppResources.Shared.Colors.primaryGray
        coverImageView.addCornerRadius(16.0)
        coverImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        coverImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        contentView.addSubview(coverImageView)
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupLabelsStackView() {
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .center
        labelsStackView.spacing = 0.0
        labelsStackView.setContentHuggingPriority(.required, for: .vertical)
        labelsStackView.setContentCompressionResistancePriority(.required, for: .vertical)
        contentView.addSubview(labelsStackView)
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelsStackView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 16.0),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 1
        titleLabel.textColor = AppResources.Shared.Colors.white()
        titleLabel.font = AppResources.Shared.Fonts.nunitoSansBold(ofSize: 20)
        titleLabel.lineBreakMode = .byTruncatingTail
        
        labelsStackView.addArrangedSubview(titleLabel)
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.numberOfLines = 1
        descriptionLabel.textColor = AppResources.Shared.Colors.white(withAlphaComponent: 0.8)
        descriptionLabel.font =  AppResources.Shared.Fonts.nunitoSansBold(ofSize: 14)
        descriptionLabel.lineBreakMode = .byTruncatingTail
        
        labelsStackView.addArrangedSubview(descriptionLabel)
    }
    
    func apply(_ configuration: Configuration) {
        titleLabel.text = configuration.bookName
        descriptionLabel.text = configuration.authorName
        coverImageView.setImage(from: configuration.coverUrl)
        transform = .identity
        labelsStackView.alpha = 0.0
    }
    
    func applyState(_ state: State) {
        UIView.animate(withDuration: 0.2) {
            switch state {
            case .scaled:
                self.applyTransformation()
            case .default:
                self.resetTransformation()
            }
        }
    }
    
    private func applyTransformation() {
        transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        coverImageView.alpha = 1.0
        labelsStackView.alpha = 1.0
    }
    
    private func resetTransformation() {
        transform = .identity
        coverImageView.alpha = 0.7
        labelsStackView.alpha = 0.0
    }
    
}

//MARK: - Configuration

extension BookCoverCell {
    
    struct Configuration {
        
        let bookName: String
        let authorName: String
        let coverUrl: URL
        
    }
    
}
