//
//  PhotoViewController.swift
//  AgileEngine
//
//  Created by Oleksandr Deundiak on 03.06.2020.
//  Copyright © 2020 Oleksandr Deundiak. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class PhotoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImageId: String!
    private var queue = DispatchQueue(label: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.queue.async {
            do {
                let details = try Shared.client.getImageDetails(imageId: self.selectedImageId)
                self.imageView.sd_setImage(with: details.fullPicture, completed: nil)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
