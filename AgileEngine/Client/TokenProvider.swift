//
//  TokenProvider.swift
//  AgileEngine
//
//  Created by Oleksandr Deundiak on 03.06.2020.
//  Copyright © 2020 Oleksandr Deundiak. All rights reserved.
//

import Foundation

class TokenProvider {
    private let mutex = Mutex()
    private let baseClient: BaseClient
    private let condition: NSCondition
    private var refreshInProcess = false
    var lastSuccessfulRefresh: Date? = nil
    
    private static let minRefreshInterval: TimeInterval = 60 // FIXME
    
    private var token: String? = nil
    
    init(baseClient: BaseClient) {
        self.baseClient = baseClient
        self.condition = NSCondition()
    }
}

extension TokenProvider: TokenProviderProtocol {
    func getToken() throws -> String {
        if self.token == nil {
            try self.refreshToken()
        }
        
        self.condition.lock()
        
        defer {
            self.condition.unlock()
        }
        
        while self.refreshInProcess {
            self.condition.wait()
        }
        
        if let str = self.token {
            return str
        }
        
        guard let str = self.token else {
            throw NSError() // FIXME
        }
        
        return str
    }
    
    func refreshToken() throws {
        if let lastSuccessfulRefrest = self.lastSuccessfulRefresh,
        lastSuccessfulRefrest.distance(to: Date()) < TokenProvider.minRefreshInterval {
            return
        }
        
        try self.mutex.lock()
        
        if let lastSuccessfulRefrest = self.lastSuccessfulRefresh,
        lastSuccessfulRefrest.distance(to: Date()) < TokenProvider.minRefreshInterval {
            return
        }
        
        defer {
            try! self.mutex.unlock()
        }
        
        self.condition.lock()
        
        defer {
            self.condition.unlock()
        }
        
        if self.refreshInProcess {
            fatalError("Multithreading issue")
        }
        
        self.refreshInProcess = true
        
        self.token = try self.baseClient.getToken().token
        
        self.refreshInProcess = false
        self.lastSuccessfulRefresh = Date()
        self.condition.signal()
    }
}
