//
//  GridViewController.swift
//  AgileEngine
//
//  Created by Oleksandr Deundiak on 03.06.2020.
//  Copyright © 2020 Oleksandr Deundiak. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: GridViewDataSource!
    var client: Client!
    private var queue = DispatchQueue(label: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "GridViewCell", bundle: Bundle.main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "gridViewCellIdentifier")
        
        let dataSource = GridViewDataSource()
        self.dataSource = dataSource
        
        self.collectionView.dataSource = dataSource
        
        self.queue.async {
            do {
                let images = try Shared.client.getImages(page: 1)
                
                dataSource.images = images.pictures
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            catch {
                print("Error \(error)")
            }
        }
        
        self.collectionView.delegate = self
    }
    
    private var selectedImageId: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showDetails" {
            let photoViewController = segue.destination as! PhotoViewController
            photoViewController.selectedImageId = self.selectedImageId!
        }
    }
}

extension GridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImageId = self.dataSource.images[indexPath.row].id
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
}

