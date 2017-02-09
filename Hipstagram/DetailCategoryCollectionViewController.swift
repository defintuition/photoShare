//
//  DetailCategoryCollectionViewController.swift
//  Hipstagram
//
//  Created by Karen Fuentes on 2/7/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetailCategoryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var categorySelectedName: String = ""
    var categorySelectedImage = UIImage()
    
    let sectionInsets = UIEdgeInsets.zero
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //left column cell
        self.collectionView!.register(DetailCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: DetailCategoriesCollectionViewCell.cellIdentifier)
        
        //right column cell
        self.collectionView?.register(SecondDetailCollectionViewCell.self, forCellWithReuseIdentifier: SecondDetailCollectionViewCell.cellIdentifier)
        
        self.title = categorySelectedName
    }
    
    // MARK: UICollectionViewDataSource Methods
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row % 2 == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCategoriesCollectionViewCell.cellIdentifier, for: indexPath) as! DetailCategoriesCollectionViewCell
            
            cell.cellImage.image = categorySelectedImage
            cell.backgroundColor = .white
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondDetailCollectionViewCell.cellIdentifier, for: indexPath) as! SecondDetailCollectionViewCell
        
        cell.cellImage.image = categorySelectedImage
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width * 0.50
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let nav = navigationController {
            let detailContoller = PhotoDetailViewController()
            let backItem = UIBarButtonItem()
            backItem.title = " "
            navigationItem.backBarButtonItem = backItem
            
            nav.pushViewController(detailContoller, animated: true)
        }
    }
}

