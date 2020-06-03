//
//  Client.swift
//  AgileEngine
//
//  Created by Oleksandr Deundiak on 03.06.2020.
//  Copyright © 2020 Oleksandr Deundiak. All rights reserved.
//

import Foundation
import Alamofire

class Client {
    let tokenProvider: TokenProviderProtocol
    
    init(tokenProvider: TokenProviderProtocol) {
        self.tokenProvider = tokenProvider
    }
}

extension Client: ClientProtocol {    
    func getImages(page: Int) throws -> ImagesPageModel {
        let token = try self.tokenProvider.getToken()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
        ]
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var result: Result<ImagesPageModel, AFError>!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request("http://interview.agileengine.com/images",
                   headers: headers)
            .validate()
            .responseDecodable(of: ImagesPageModel.self, decoder: decoder) { response in
                defer {
                    semaphore.signal()
                }
                   
                result =  response.result
        }
        
        semaphore.wait()
        
        return try result.get()
    }
    
    func getImageDetails(imageId: String) throws -> ImageDetails {
        let token = try self.tokenProvider.getToken()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
        ]
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var result: Result<ImageDetails, AFError>!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request("http://interview.agileengine.com/images/\(imageId)",
                   headers: headers)
            .validate()
            .responseDecodable(of: ImageDetails.self, decoder: decoder) { response in
                defer {
                    semaphore.signal()
                }

                result =  response.result
        }
        
        semaphore.wait()
        
        return try result.get()
    }
}
