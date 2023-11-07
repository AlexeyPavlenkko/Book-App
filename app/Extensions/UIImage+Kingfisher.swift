//
//  UIImage+Kingfisher.swift
//  app
//
//  Created by Алексей Павленко on 06.11.2023.
//

import UIKit
import Kingfisher

typealias DownloadImageCompletion = (_ image: UIImage?, _ error: Error?) -> Void

extension UIImageView {
    
    func setImage(
        from imageURL: URL?,
        placeholder: UIImage? = nil,
        options: KingfisherOptionsInfo? = nil,
        completion: DownloadImageCompletion? = nil
    ) {
        kf.setImage(with: imageURL, placeholder: placeholder, options: options) { result in
            switch result {
            case .success(let value):
                completion?(value.image, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    func cancelImageFetching() {
        kf.cancelDownloadTask()
    }
    
}
