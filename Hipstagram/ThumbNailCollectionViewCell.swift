//
//  ThumbNailCollectionViewCell.swift
//  Hipstagram
//
//  Created by Amber Spadafora on 2/8/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//


import UIKit
import SnapKit

class ThumbNailCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        addSubview(thumbPhotoImageView)
        thumbPhotoImageView.snp.makeConstraints({ (image) in
            image.top.equalTo(self.snp.top)
            image.bottom.equalTo(self.snp.bottom)
            image.leading.equalTo(self.snp.leading)
            image.trailing.equalTo(self.snp.trailing)
        })
    }
    
    lazy var thumbPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        return imageView
    }()
    
    
    
    
}
