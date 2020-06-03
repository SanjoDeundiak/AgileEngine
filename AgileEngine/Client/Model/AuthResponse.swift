//
//  AuthResponse.swift
//  AgileEngine
//
//  Created by Oleksandr Deundiak on 03.06.2020.
//  Copyright © 2020 Oleksandr Deundiak. All rights reserved.
//

import Foundation

struct AuthResponse: Decodable {
    let auth: Bool
    let token: String
}
