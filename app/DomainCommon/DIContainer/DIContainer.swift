//
//  DIContainer.swift
//  app
//
//  Created by Алексей Павленко on 05.11.2023.
//

import Foundation

final class DIContainer {
    
    private var storage = [String: Any]()
    private let queue = DispatchQueue(label: "di_container_private_queue")
    
    init(_ container: DIContainer? = nil) {
        if let container = container {
            storage = container.storage
        }
    }
    
    // MARK: - Registration (up to 3 arguments but can be expanded to more)
    func register<T>(_ service: T.Type, with key: String? = nil, factory: @escaping () -> T) {
        let _key: String = key ?? createKey(for: service, argumentsCount: 0)
        
        queue.sync { [weak self] in
            guard let self else { return }
            
            self.storage.updateValue(factory, forKey: _key)
        }
    }
    
    func register<T, Arg1>(_ service: T.Type, with key: String? = nil, factory: @escaping (Arg1) -> T) {
        let _key: String = key ?? createKey(for: service, argumentsCount: 1)
        
        queue.sync { [weak self] in
            guard let self else { return }
            
            self.storage.updateValue(factory, forKey: _key)
        }
    }
    
    func register<T, Arg1, Arg2>(_ service: T.Type, with key: String? = nil, factory: @escaping (Arg1, Arg2) -> T) {
        let _key: String = key ?? createKey(for: service, argumentsCount: 2)
        
        queue.sync { [weak self] in
            guard let self else { return }
            
            self.storage.updateValue(factory, forKey: _key)
        }
    }
    
    func register<T, Arg1, Arg2, Arg3>(_ service: T.Type, with key: String? = nil, factory: @escaping (Arg1, Arg2, Arg3) -> T) {
        let _key: String = key ?? createKey(for: service, argumentsCount: 3)
        
        queue.sync { [weak self] in
            guard let self else { return }
            
            self.storage.updateValue(factory, forKey: _key)
        }
    }
    
    // MARK: - Resolving (up to 3 arguments but can be expanded to more)
    func resolve<T>(using key: String? = nil) -> T! {
        let _key: String = key ?? createKey(for: T.self, argumentsCount: 0)
        
        return queue.sync { [weak self] in
            guard let factory = self?.storage[_key] as? () -> T else {
                preconditionFailure("Unknown key \(_key) or can't resolve \(String(describing: T.self))")
            }
            
            return factory()
        }
    }
    
    func resolve<T, Arg1>(using key: String? = nil, argument: Arg1) -> T! {
        let _key: String = key ?? createKey(for: T.self, argumentsCount: 1)
        
        return queue.sync { [weak self] in
            guard let factory = self?.storage[_key] as? (Arg1) -> T else {
                preconditionFailure("Unknown key \(_key) or can't resolve \(String(describing: T.self))")
            }
            
            return factory(argument)
        }
    }
    
    func resolve<T, Arg1, Arg2>(using key: String? = nil, argument: Arg1, _ arg2: Arg2) -> T! {
        let _key: String = key ?? createKey(for: T.self, argumentsCount: 2)
        
        return queue.sync { [weak self] in
            guard let factory = self?.storage[_key] as? (Arg1, Arg2) -> T else {
                preconditionFailure("Unknown key \(_key) or can't resolve \(String(describing: T.self))")
            }
            
            return factory(argument, arg2)
        }
    }
    
    func resolve<T, Arg1, Arg2, Arg3>(using key: String? = nil, argument: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> T! {
        let _key: String = key ?? createKey(for: T.self, argumentsCount: 3)
        
        return queue.sync { [weak self] in
            guard let factory = self?.storage[_key] as? (Arg1, Arg2, Arg3) -> T else {
                preconditionFailure("Unknown key \(_key) or can't resolve \(String(describing: T.self))")
            }
            
            return factory(argument, arg2, arg3)
        }
    }
    
    // MARK: - Key Generator
    private func createKey<T>(for service: T.Type, argumentsCount: Int) -> String {
        "\(String(describing: service)).\(argumentsCount).arguments"
    }
    
}
