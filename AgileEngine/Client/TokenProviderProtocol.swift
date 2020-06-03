//
//  TokenProviderProtocol.swift
//  AgileEngine
//
//  Created by Oleksandr Deundiak on 03.06.2020.
//  Copyright © 2020 Oleksandr Deundiak. All rights reserved.
//

import Foundation

protocol TokenProviderProtocol {
    func getToken() throws -> String
}
