//
//  LibraryViewController.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import UIKit
import Combine

final class LibraryViewController: BaseViewController {
    
    //MARK: Properties
    
    override var prefersStatusBarHidden: Bool { true }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    private let viewModel: LibraryViewModel
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Init
    
    init(viewModel: LibraryViewModel) {
        self.viewModel = viewModel
        super.init()
        
        initializeBindings()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppResources.Shared.Colors.black()
        navigationItem.removeBackButtonTitle()
        setupCollectionView()
        viewModel.fetchLibraryInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: Methods
    
    private func setupCollectionView() {
        collectionView.registerReusableCell(cellType: LibraryBannerCell.self)
        collectionView.registerReusableCell(cellType: LibraryBookCell.self)
        collectionView.registerReusableSupplementaryView(
            elementKind: UICollectionView.elementKindSectionHeader,
            viewType: LibraryHeaderView.self
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .init(top: view.safeAreaInsets.top, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
        
        collectionView.disableTranslateAutoresizingMask()
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func initializeBindings() {
        viewModel.updateContentAction
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.reloadCollectionView()
            }
            .store(in: &cancellables)
    }
    
    private func reloadCollectionView() {
        collectionView.reloadData()
        collectionView.setCollectionViewLayout(createCollectionViewLayout(), animated: true)
    }
    
}

//MARK: - UICollectionViewDataSource
extension LibraryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.librarySections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.librarySections[section].rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let content = viewModel.librarySections[indexPath.section].rows[indexPath.row]
        
        return LibraryViewsFractory.cell(content: content, collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = viewModel.librarySections[indexPath.section]
        
        return LibraryViewsFractory.header(section: section, collectionView: collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
    
}

//MARK: - UICollectionViewDelegate

extension LibraryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectBook(indexPath)
    }
    
}

// MARK: - CollectionViewLayout

extension LibraryViewController {
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env in
            guard let self = self else { return nil }
            
            let sectionType = viewModel.librarySections[sectionIndex].type
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(25))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            headerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            
            switch sectionType {
            case .banner:
                let section =  createBannerSectionLayout()
                section.contentInsets = NSDirectionalEdgeInsets(top: 28, leading: 16, bottom: 35, trailing: 16)
                section.supplementaryContentInsetsReference = .none
                section.boundarySupplementaryItems = [headerItem]
                return section
                
            case .books:
                let section =  createBooksSectionLayout()
                section.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 16, bottom: 24, trailing: 16)
                section.supplementaryContentInsetsReference = .none
                section.boundarySupplementaryItems = [headerItem]
                return section
            }
        }
        
        return layout
    }
    
    private func createBannerSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.45))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createBooksSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.32), heightDimension: .fractionalWidth(0.51))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
}
