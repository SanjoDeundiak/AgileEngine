//
//  ImagesPageModel.swift
//  AgileEngine
//
//  Created by Oleksandr Deundiak on 03.06.2020.
//  Copyright © 2020 Oleksandr Deundiak. All rights reserved.
//

import Foundation

struct ImagesPageModel: Decodable {
    let pictures: [CroppedPictureModel]
    let page: Int
    let pageCount: Int
    let hasMore: Bool
    
}
