//
//  GridViewDataSource.swift
//  AgileEngine
//
//  Created by Oleksandr Deundiak on 03.06.2020.
//  Copyright © 2020 Oleksandr Deundiak. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class GridViewDataSource: NSObject {
    var images: [CroppedPictureModel] = []
}

extension GridViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridViewCellIdentifier", for: indexPath) as! GridViewCell
        
        guard indexPath.row < self.images.count else {
            cell.imageView.image = nil
            return cell
        }
        
        cell.imageView.sd_setImage(with: self.images[indexPath.row].croppedPicture, completed: nil)
        
        return cell
    }
    
    
}
