//
//  SplashViewController.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import UIKit

final class SplashViewController: BaseViewController {
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let progressView = UIProgressView()
    
    private let viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        view = BackgroundView {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.image = AppResources.SplashResources.Images.background
            return imageView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateSplashLoading()
    }
    
    private func setupView() {
        [titleLabel, descriptionLabel, progressView].forEach { $0.disableTranslateAutoresizingMask() }
        
        setupDescriptionLabel()
        setupTitleLabel()
        setupProgressView()
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.font = AppResources.Shared.Fonts.georgiaBoldItalic(ofSize: 52)
        titleLabel.textColor = AppResources.Shared.Colors.lightPink
        titleLabel.text = AppResources.SplashResources.Strings.bookApp
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -12),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        
        descriptionLabel.font = AppResources.Shared.Fonts.nunitoSansBold(ofSize: 24.0)
        descriptionLabel.textColor = AppResources.Shared.Colors.white(withAlphaComponent: 0.8)
        descriptionLabel.text = AppResources.SplashResources.Strings.welcome
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupProgressView() {
        view.addSubview(progressView)
        
        progressView.progressTintColor = AppResources.Shared.Colors.white(withAlphaComponent: 0.8)
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            progressView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 52)
        ])
    }
    
    private func animateSplashLoading() {
        let stubView = UIView(frame: .infinite)
        stubView.backgroundColor = .clear
        stubView.alpha = 0.0
        self.view.addSubview(stubView)
        
        UIView.animate(withDuration: viewModel.splashDuration) {
            self.progressView.setProgress(1, animated: true)
            stubView.alpha = 1.0
        } completion: { _ in
            stubView.removeFromSuperview()
            self.viewModel.didEndSplashLoading()
        }
    }
    
}
