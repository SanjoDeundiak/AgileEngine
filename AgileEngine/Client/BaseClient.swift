//
//  BaseClient.swift
//  AgileEngine
//
//  Created by Oleksandr Deundiak on 03.06.2020.
//  Copyright © 2020 Oleksandr Deundiak. All rights reserved.
//

import Foundation
import Alamofire

enum BaseClientError: Error {
    case unknownError
}

class BaseClient {
    func getToken() throws -> AuthResponse {
        let semaphore = DispatchSemaphore(value: 0)
        
        var result: Result<AuthResponse, AFError>!
        
        let parameters = [
            "apiKey": "23567b218376f79d9415"
        ]
        
        AF.request("http://interview.agileengine.com/auth",
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: AuthResponse.self) { response in
                defer {
                    semaphore.signal()
                }
                    
                result = response.result
        }
        
        semaphore.wait()
        
        return try result.get()
    }
}
