//
//  LibraryBannerCell.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit

final class LibraryBannerCell: UICollectionViewCell, Reusable {
    
    //MARK: Properties
    
    private let scrollView = UIScrollView()
    private let slidesStackView = UIStackView()
    private let pageControl = UIPageControl()
    private var slides = [UIImageView]()
    
    private var timer: Timer?
    
    private var clickAction: ((Int) -> Void)?
    private var slidesInfo: [BannerInfo] = []
    private var fakeSlidesInfo: [BannerInfo] = []
    
    private var currentSlideIndex: Int = 1
    
    private var isTimerActive: Bool {
        timer?.isValid ?? false
    }
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    deinit { invalidateTimer() }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        slides.forEach { $0.cancelImageFetching() }
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        [scrollView, slidesStackView, pageControl].forEach { $0.disableTranslateAutoresizingMask() }
        
        setupScrollView()
        setupStackView()
        setupPageControll()
        
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }
    
    private func setupScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        contentView.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    private func setupPageControll() {
        pageControl.currentPageIndicatorTintColor = AppResources.Shared.Colors.primaryPink
        pageControl.pageIndicatorTintColor = AppResources.Shared.Colors.indicatorGray
        pageControl.numberOfPages = 5
        
        contentView.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 8.0)
        ])
    }
    
    private func setupStackView() {
        slidesStackView.axis = .horizontal
        slidesStackView.spacing = 0.0
        
        scrollView.addSubview(slidesStackView)
        NSLayoutConstraint.activate([
            slidesStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            slidesStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            slidesStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            slidesStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            slidesStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.0)
        ])
    }
    
    private func setupSlides() {
        guard !slidesInfo.isEmpty, let firstInfo = slidesInfo.first, let lastInfo = slidesInfo.last else { return }
        
        slidesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        fakeSlidesInfo = [lastInfo] + slidesInfo + [firstInfo]
        currentSlideIndex = 1
        pageControl.currentPage = 0
        
        fakeSlidesInfo.forEach { slideInfo in
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.setImage(from: slideInfo.coverUrl)
            imageView.disableTranslateAutoresizingMask()
            imageView.backgroundColor = AppResources.Shared.Colors.primaryGray
            imageView.addCornerRadius(16.0)
            slides.append(imageView)
            slidesStackView.addArrangedSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0)
            ])
        }
        
        setNeedsLayout()
        layoutIfNeeded()
        invisibleScrollToSlide(at: 1)
    }
    
    private func fireTimer() {
        invalidateTimer()
        let fire = Date().addingTimeInterval(3)
        timer = Timer(fire: fire, interval: 3.0, repeats: true) { [weak self] _ in
            self?.makeAutoScroll()
        }
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func makeAutoScroll() {
        let potentialIndex = currentSlideIndex + 1
        let nextIndex = potentialIndex < fakeSlidesInfo.count ? potentialIndex : 1
        let rect = slides[nextIndex].frame
        
        scrollView.setContentOffset(.init(x: rect.width * CGFloat(nextIndex), y: 0), animated: true)
    }
    
    private func invisibleScrollToSlide(at index: Int) {
        let rect = slides[index].frame
        
        scrollView.setContentOffset(.init(x: rect.width * CGFloat(index), y: 0), animated: false)
    }
    
    @objc private func didTap() {
        clickAction?(slidesInfo[pageControl.currentPage].bookId)
    }
    
    func apply(_ configuration: Configuration) {
        slidesInfo = configuration.slides
        pageControl.numberOfPages = configuration.slides.count
        clickAction = configuration.clickAction
        
        setupSlides()
        fireTimer()
    }
    
}

//MARK: - UIScrollViewDelegate

extension LibraryBannerCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int((scrollView.contentOffset.x / scrollView.bounds.width).rounded())
        if index == 0 {
            pageControl.currentPage = slidesInfo.count - 1
            currentSlideIndex = fakeSlidesInfo.count - 2
        } else if index == fakeSlidesInfo.count - 1 {
            pageControl.currentPage = 0
            currentSlideIndex = 1
        } else {
            pageControl.currentPage = index - 1
            currentSlideIndex = index
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard isTimerActive else { return }
        
        invisibleScrollToSlide(at: currentSlideIndex)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard !isTimerActive else { return }
        
        invisibleScrollToSlide(at: currentSlideIndex)
        fireTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !isTimerActive && !decelerate else { return }
        
        fireTimer()
        invisibleScrollToSlide(at: currentSlideIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        invalidateTimer()
    }
    
}

//MARK: - Configuration

extension LibraryBannerCell {
    
    struct Configuration {
        
        let slides: [BannerInfo]
        let clickAction: (Int) -> Void
        
    }
    
}
