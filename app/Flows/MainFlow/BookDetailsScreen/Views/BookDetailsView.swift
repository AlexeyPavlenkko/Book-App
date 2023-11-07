//
//  BookDetailsView.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit

final class BookDetailsView: BaseView {
    
    //MARK:  Properties
    
    private let mainScrollView = UIScrollView()
    private let mainStackView = UIStackView()
    private let mainContentView = UIView()
    
    private let statisticStackView = UIStackView()
    private let readersLabel = StatisticDoubleLabel()
    private let likesLabel = StatisticDoubleLabel()
    private let quotesLabel = StatisticDoubleLabel()
    private let genreLabel = StatisticDoubleLabel()
    
    private let summaryStackView = UIStackView()
    private let summaryHeaderLabel = UILabel()
    private let summaryDiscriptionLabel = UILabel()
    
    private let recommendedContentView = UIView()
    private let recommendedHeaderLabel = UILabel()
    private let recommendedStackView = UIStackView()
    private let recommendedBooksViews = UIView()
    
    private let buttonContainer = UIView()
    private let readNowButton = BaseButton()
    
    //MARK: Lifecycle
    
    override init() {
        super.init()
        
        addCornerRadius(16.0, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        backgroundColor = AppResources.Shared.Colors.white()
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        readNowButton.makeViewRound()
    }
    
    //MARK: Methods
    
    private func setupViews() {
        setupMainScrollView()
        setupMainContentView()
        setupMainStackView()
        setupStatisticsSection()
        setupSummarySection()
        setupRecommendedSection()
        setupReadNowButton()
    }
    
    private func setupMainScrollView() {
        mainScrollView.disableTranslateAutoresizingMask()
        
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.showsHorizontalScrollIndicator = false
        
        addSubview(mainScrollView)
        NSLayoutConstraint.activate([
            mainScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainScrollView.topAnchor.constraint(equalTo: topAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainScrollView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    private func setupMainContentView() {
        mainContentView.disableTranslateAutoresizingMask()

        mainScrollView.addSubview(mainContentView)
        
        NSLayoutConstraint.activate([
            mainContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            mainContentView.topAnchor.constraint(equalTo: topAnchor, constant: 21.0),
            mainContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            mainContentView.bottomAnchor.constraint(lessThanOrEqualTo: mainScrollView.bottomAnchor)
        ])
    }
    
    private func setupMainStackView() {
        mainStackView.disableTranslateAutoresizingMask()
        mainStackView.axis = .vertical
        mainStackView.spacing = 16.0

        mainScrollView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 21.0),
            mainStackView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -16.0)
        ])
    }
    
    private func setupStatisticsSection() {
        let statisticContentView = UIView()
        
        mainStackView.addArrangedSubview(statisticContentView)
        
        statisticStackView.disableTranslateAutoresizingMask()
        statisticContentView.addSubview(statisticStackView)
        
        NSLayoutConstraint.activate([
            statisticStackView.leadingAnchor.constraint(equalTo: statisticContentView.leadingAnchor, constant: 22.0),
            statisticStackView.trailingAnchor.constraint(equalTo: statisticContentView.trailingAnchor, constant: -22.0),
            statisticStackView.topAnchor.constraint(equalTo: statisticContentView.topAnchor),
            statisticStackView.bottomAnchor.constraint(equalTo: statisticContentView.bottomAnchor)
        ])
        
        statisticStackView.axis = .horizontal
        statisticStackView.distribution = .equalSpacing
        statisticStackView.alignment = .center
        
        statisticStackView.addArrangedSubview(readersLabel)
        statisticStackView.addArrangedSubview(likesLabel)
        statisticStackView.addArrangedSubview(quotesLabel)
        statisticStackView.addArrangedSubview(genreLabel)
        
        mainStackView.addArrangedSubview(SeparatorView(horizontalPadding: 0.0))
    }
    
    private func setupSummarySection() {
        mainStackView.addArrangedSubview(summaryStackView)
        
        summaryStackView.axis = .vertical
        summaryStackView.spacing = 8.0
        
        summaryDiscriptionLabel.numberOfLines = 0
        summaryHeaderLabel.textColor = AppResources.Shared.Colors.primaryBlack
        summaryHeaderLabel.font = AppResources.Shared.Fonts.nunitoSansBold(ofSize: 20)
        summaryHeaderLabel.textAlignment = .left
        
        summaryStackView.addArrangedSubview(summaryHeaderLabel)
        
        summaryDiscriptionLabel.textColor = AppResources.Shared.Colors.primaryBlack
        summaryDiscriptionLabel.font = AppResources.Shared.Fonts.nunitoSansSemiBold(ofSize: 14)
        summaryDiscriptionLabel.textAlignment = .left
        
        summaryStackView.addArrangedSubview(summaryDiscriptionLabel)
        
        mainStackView.addArrangedSubview(SeparatorView(horizontalPadding: 0.0))
    }
    
    private func setupRecommendedSection() {
        mainStackView.addArrangedSubview(recommendedContentView)
        
        recommendedHeaderLabel.textColor = AppResources.Shared.Colors.primaryBlack
        recommendedHeaderLabel.font = AppResources.Shared.Fonts.nunitoSansBold(ofSize: 20)
        
        recommendedHeaderLabel.disableTranslateAutoresizingMask()
        recommendedContentView.addSubview(recommendedHeaderLabel)
        NSLayoutConstraint.activate([
            recommendedHeaderLabel.leadingAnchor.constraint(equalTo: recommendedContentView.leadingAnchor),
            recommendedHeaderLabel.topAnchor.constraint(equalTo: recommendedContentView.topAnchor),
            recommendedHeaderLabel.trailingAnchor.constraint(equalTo: recommendedContentView.trailingAnchor)
        ])
        
        let scrollView = UIScrollView()
        scrollView.disableTranslateAutoresizingMask()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = .init(top: 0, left: 16.0, bottom: 0, right: 16.0)
        
        recommendedContentView.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: recommendedContentView.leadingAnchor, constant: -16.0),
            scrollView.topAnchor.constraint(equalTo: recommendedHeaderLabel.bottomAnchor, constant: 16.0),
            scrollView.trailingAnchor.constraint(equalTo: recommendedContentView.trailingAnchor, constant: 16.0),
            scrollView.bottomAnchor.constraint(equalTo: recommendedContentView.bottomAnchor)
        ])
        
        recommendedStackView.axis = .horizontal
        recommendedStackView.spacing = 8.0
        recommendedStackView.disableTranslateAutoresizingMask()
        scrollView.addSubview(recommendedStackView)
        NSLayoutConstraint.activate([
            recommendedStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            recommendedStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            recommendedStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            recommendedStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            recommendedStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
    }
    
    private func setupReadNowButton() {
        mainStackView.addArrangedSubview(buttonContainer)
        
        readNowButton.backgroundColor = AppResources.Shared.Colors.lightPink
        readNowButton.setTitle(AppResources.MainResources.Strings.readNow, for: .normal)
        readNowButton.setTitleColor(AppResources.Shared.Colors.white(), for: .normal)
        readNowButton.titleLabel?.font = AppResources.Shared.Fonts.nunitoSansExtraBold(ofSize: 16)
        readNowButton.makeViewRound()
        
        readNowButton.disableTranslateAutoresizingMask()
        buttonContainer.addSubview(readNowButton)
        NSLayoutConstraint.activate([
            readNowButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: 32.0),
            readNowButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 8.0),
            readNowButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: -32.0),
            readNowButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor),
            readNowButton.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }
    
    func apply(_ configuration: Configuration) {
        let bookInfo = configuration.bookInfo
        let recommendedBookd = configuration.recommendedBookd
        readersLabel.apply(.init(countText: bookInfo.views, topicName: AppResources.MainResources.Strings.readers))
        likesLabel.apply(.init(countText: bookInfo.likes, topicName: AppResources.MainResources.Strings.likes))
        quotesLabel.apply(.init(countText: bookInfo.quotes, topicName: AppResources.MainResources.Strings.quotes))
        genreLabel.apply(.init(countText: bookInfo.genre, topicName: AppResources.MainResources.Strings.genre))

        summaryHeaderLabel.text = AppResources.MainResources.Strings.summary
        summaryDiscriptionLabel.text = bookInfo.summary
        
        recommendedHeaderLabel.text = AppResources.MainResources.Strings.recommended
        recommendedStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        recommendedBookd.forEach { book in
            let view = RecommendedBookView()
            view.apply(.init(titleName: book.name, coverUrl: book.coverUrl))
            recommendedStackView.addArrangedSubview(view)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
        
        mainScrollView.setContentOffset(.zero, animated: false)
    }
    
}

//MARK: - Configuration

extension BookDetailsView {
    
    struct Configuration {
        
        let bookInfo: BookInfo
        let recommendedBookd: [BookInfo]
        
    }
    
}
