//
//  RemoteConfigService.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation
import FirebaseRemoteConfig

final class RemoteConfigService: NetworkService {
    
    private let config: RemoteConfig
    
    init(config: RemoteConfig = .remoteConfig()) {
        self.config = config
    }
    
    func performRequest<Parser: ResponseParser>(
        _ request: NetworkRequest,
        parser: Parser,
        completion: @escaping (Result<Parser.Representation, Error>) -> Void
    ) {
        
        config.fetchAndActivate { [weak self] _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let self = self else { return }
            
            let fetchedData = self.config.configValue(forKey: request.path).dataValue
            
            let parsedResult = parser.parse(fetchedData)
            
            completion(parsedResult)
        }
        
    }
    
}
