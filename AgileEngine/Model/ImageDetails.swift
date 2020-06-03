//
//  ImageDetails.swift
//  AgileEngine
//
//  Created by Oleksandr Deundiak on 03.06.2020.
//  Copyright © 2020 Oleksandr Deundiak. All rights reserved.
//

import Foundation

struct ImageDetails: Decodable {
    let id: String
    let author: String
    let camera: String
    let tags: String
    let croppedPicture: URL
    let fullPicture: URL
}
