//
//  BookDetailsViewController.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit
import Combine

final class BookDetailsViewController: BaseViewController {
    
    //MARK: Properties
    
    private let viewModel: BookDetailsViewModel
    
    private let bookDetailsView = BookDetailsView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: BooksCoverFlowLayout())
    private var centerCell: BookCoverCell?
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Init
    
    init(viewModel: BookDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
        
        initializeBindings()
    }
    
    //MARK: Lifecycle
    
    override func loadView() {
        view = BackgroundView {
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.image = AppResources.MainResources.Images.blanket
            return imageView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setupCollectionView()
        setupBookDetailsView()
        viewModel.fetchContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollViewDidScroll(collectionView)
    }
    
    //MARK: Methods
    
    private func setupCollectionView() {
        collectionView.registerReusableCell(cellType: BookCoverCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.decelerationRate = .init(rawValue: 0.01)
        
        collectionView.disableTranslateAutoresizingMask()
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 328)
        ])
    }
    
    private func setupBookDetailsView() {
        bookDetailsView.disableTranslateAutoresizingMask()
        
        view.addSubview(bookDetailsView)
        
        NSLayoutConstraint.activate([
            bookDetailsView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16.0),
            bookDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bookDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func initializeBindings() {
        viewModel.updateContentAction
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.reloadContent()
            }
            .store(in: &cancellables)
    }
    
    private func reloadContent() {
        collectionView.reloadData()
        collectionView.scrollToItem(at: .init(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        let currentBook = viewModel.booksInfo[0]
        bookDetailsView.apply(.init(bookInfo: currentBook, recommendedBookd: viewModel.recommendedBooks))
    }
    
}

//MARK: - UICollectionViewDataSource

extension BookDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.booksInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bookCell = collectionView.dequeueReusableCell(indexPath, cellType: BookCoverCell.self)
        let bookInfo = viewModel.booksInfo[indexPath.row]
        
        bookCell.apply(.init(bookName: bookInfo.name, authorName: bookInfo.author, coverUrl: bookInfo.coverUrl))
        
        return bookCell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension BookDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerPoint = CGPoint(
            x: collectionView.frame.size.width / 2 + scrollView.contentOffset.x,
            y: collectionView.frame.size.height / 2 + scrollView.contentOffset.y
        )
        if let indexPath = self.collectionView.indexPathForItem(at: centerPoint), self.centerCell == nil {
            self.centerCell = (self.collectionView.cellForItem(at: indexPath) as? BookCoverCell)
            self.centerCell?.applyState(.scaled)
            let bookInfo = viewModel.booksInfo[indexPath.row]
            bookDetailsView.apply(.init(bookInfo: bookInfo, recommendedBookd: viewModel.recommendedBooks))
        }
        
        if let centerCell = centerCell {
            let offsetX = centerPoint.x - centerCell.center.x
            
            if offsetX < -100 || offsetX > 100 {
                centerCell.applyState(.default)
                self.centerCell = nil
            }
        }
    }
    
}
